#!BPY
"""
Name: 'Spring S3O (.s3o)...'
Blender: 260
Group: 'Import'
Tooltip: 'Import from S3O file format (.s3o)
"""

__author__= ['Jez Kabanov']
__url__= ("http://springrts.com")
__version__ = '0.6'
__bpydoc__= '''\
'''

import Blender
import bpy
import sys
import math
from Blender import Mesh, Object, Material, Image, Texture, Lamp, Mathutils, Window
from Blender.Mathutils import Vector
import BPyImage

import BPyMessages

import struct
from struct import calcsize, unpack

import os
try:
	os.SEEK_SET
except AttributeError:
	os.SEEK_SET, os.SEEK_CUR, os.SEEK_END = range(3)

def read_string(file, offset):
	file.seek(offset, os.SEEK_SET)
	string = ''
	c = file.read(1)
	while(c != '' and c != '\0'):
		string += c
		c = file.read(1)
	
	return string

class s3o_header(object):
	binary_format = "<12sI5f4I"

	magic = 'Spring unit'  # char [12] "Spring unit\0"
	version = 0	# uint = 0
	radius = 0.0 # float: radius of collision sphere
	height = 0.0 # float: height of whole object
	midx = 0.0 # float offset from origin
	midy = 0.0 #
	midz = 0.0 #
	rootPieceOffset = 0 # offset of root piece
	collisionDataOffset = 0 # offset of collision data, 0 = no data
	texture1Offset = 0 # offset to filename of 1st texture
	texture2Offset = 0 # offset to filename of 2nd texture

	def load(self, file):
		tmp_data = file.read(struct.calcsize(self.binary_format))
		data = struct.unpack(self.binary_format, tmp_data)
		self.magic = asciiz(data[0])
		if(self.magic != 'Spring unit'):
			raise NameError, 'Not a Spring unit file: \'' + self.magic + '\''
			return
		self.version = data[1]
		if(self.version != 0):
			raise NameError, 'Wrong file version: ' + self.version
			return
		self.radius	= data[2]
		self.height	= data[3]
		self.midx	= -data[4]
		self.midy	= data[5]
		self.midz	= data[6]
		self.rootPieceOffset = data[7]
		self.collisionDataOffset = data[8]

		self.texture1Offset = data[9]
		if(self.texture1Offset == 0):
			self.texture1 = ''
		else:
			self.texture1 = read_string(file, self.texture1Offset)

		self.texture2Offset = data[10]
		if(self.texture2Offset == 0):
			self.texture2 = ''
		else:
			self.texture2 = read_string(file, self.texture2Offset)
		return

class s3o_piece(object):
	binary_format = "<10I3f"

	name = ''
	verts = []
	faces = []
	parent = '' 
	children = []

	nameOffset = 0 # uint
	numChildren = 0 # uint
	childrenOffset = 0 # uint
	numVerts = 0 # uint
	vertsOffset = 0 # uint
	vertType = 0 # uint
	primitiveType = 0 # 0 = tri, 1 = tristrips, 2 = quads
	vertTableSize = 0 # number of indexes in vert table
	vertTableOffset = 0
	collisionDataOffset = 0
	xoffset = 0.0
	yoffset = 0.0
	zoffset = 0.0

	def load(self, file, offset, material):
		file.seek(offset, os.SEEK_SET)
		tmp_data = file.read(struct.calcsize(self.binary_format))
		data = struct.unpack(self.binary_format, tmp_data)

		self.nameOffset = data[0]
		self.numChildren = data[1]
		self.childrenOffset = data[2]
		self.numVerts = data[3]
		self.vertsOffset = data[4]
		self.vertType = data[5]
		self.primitiveType = data[6]
		self.vertTableSize = data[7]
		self.vertTableOffset = data[8]
		self.collisionDataOffset = data[9]
		self.xoffset = data[10]
		self.yoffset = data[11]
		self.zoffset = data[12]

		# load self
		# get name
		file.seek(self.nameOffset, os.SEEK_SET)
		self.name = read_string(file, self.nameOffset)

		print "loading piece '" + self.name + "'"

		# load verts
		print "loading " + str(self.numVerts) + " verts"
		self.verts = []
		for i in range(0, self.numVerts):
			vert = s3o_vert()
			vert.load(file, self.vertsOffset + (i * struct.calcsize(vert.binary_format)))
			self.verts.append(vert)

		# load primitives
		file.seek(self.vertTableOffset, os.SEEK_SET)
		self.faces = []
		self.face_uvs = []
		if(self.primitiveType == 0): # triangles
			i = 0
			while(i < self.vertTableSize):
				tmp = file.read(4 * 3)
				data = struct.unpack("<3I", tmp)
				face = [ int(data[0]), int(data[1]), int(data[2]) ]
				self.faces.append(face)

				i += 3

		elif(self.primitiveType == 1): # tristrips
			raise NameError, 'Tristrips are unsupported so far'

		elif(self.primitiveType == 2): # quads
			i = 0
			while(i < self.vertTableSize):
				tmp = file.read(4 * 4)
				data = struct.unpack("<4I", tmp)
				face = [ int(data[0]), int(data[1]), int(data[2]), int(data[3]) ]
				self.faces.append(face)
				i += 4

		else:
			raise NameError, 'Unknown primitive type: ' + self.primitiveType

		print "loaded "+ str(len(self.faces))+" faces"

		print "finished loading piece '"+ self.name +"'"

		scn = Blender.Scene.GetCurrent()

		# if it has no verts or faces create an EMPTY instead
		if(self.numVerts == 0):
			self.ob = scn.objects.new('Empty')
			self.ob.setName(self.name)
			self.ob.emptyShape = Object.EmptyShapes.CUBE
		else:
			print "constructing mesh..."
			self.mesh = bpy.data.meshes.new(self.name)
			self.mesh.verts.extend(self.get_verts())
			self.mesh.faces.extend(self.faces)
			self.mesh.calcNormals();

			if(len(self.mesh.faces) > 0):
				self.mesh.faceUV = True
				faces = self.mesh.faces
				# set UVs and normals
				for f in faces:
					f.smooth = True
					tex = material.getTextures()[0]
					if(tex != None and tex.tex.image):
						f.image = tex.tex.image
					i = 0
					for v in f.verts:
						f.uv[i].x = self.verts[v.index].texu
						f.uv[i].y = self.verts[v.index].texv
						# for non .dds textures we need to flip texv
						if(tex != None and tex.tex.image):
							ext = tex.tex.image.getFilename()[-4:]
							if(ext != '.dds' and ext != '.DDS'):
								f.uv[i].y = 1.0 - self.verts[v.index].texv
						# set normals
						no= Blender.Mathutils.Vector(self.verts[v.index].xnormal,self.verts[v.index].ynormal,self.verts[v.index].znormal)
						i += 1

			self.ob = scn.objects.new(self.mesh)
			self.mesh.materials += [material]
			self.mesh.update()
	
		if(self.parent):
			self.parent.ob.makeParent([self.ob], 1)
			self.ob.setLocation(self.xoffset, self.yoffset, self.zoffset)
		else:
			self.ob.setLocation(self.xoffset, self.yoffset, self.zoffset)


		# load children
		if(self.numChildren > 0):
			print "loading " + str(self.numChildren) + " children"
			# childrenOffset contains DWORDS containing offsets to child pieces
			file.seek(self.childrenOffset, os.SEEK_SET)
			for i in range(0, self.numChildren):
				tmp = file.read(4)
				offset = file.tell()
				data = struct.unpack("<I", tmp)
				childOffset = data[0]
				child = s3o_piece()
				child.parent = self
				child.load(file, childOffset, material)
				self.children.append(child)
				file.seek(offset, os.SEEK_SET)

		return

	def get_verts(self):
		tmp_verts = []
		for i in range(0,len(self.verts)):
			tmp_verts.append( [ self.verts[i].xpos, self.verts[i].ypos, self.verts[i].zpos ] )
		return tmp_verts

class s3o_vert(object):
	binary_format = "<8f"
	xpos = 0.0
	ypos = 0.0
	zpos = 0.0
	xnormal = 0.0
	ynormal = 0.0
	znormal = 0.0
	texu = 0.0
	texv = 0.0

	def load(self, file, offset):
		file.seek(offset, os.SEEK_SET)
		tmp_data = file.read(struct.calcsize(self.binary_format))
		data = struct.unpack(self.binary_format, tmp_data)

		self.xpos = data[0]
		self.ypos = data[1]
		self.zpos = data[2]
		self.xnormal = data[3]
		self.ynormal = data[4]
		self.znormal = data[5]
		self.texu = data[6]
		self.texv = data[7]

def asciiz (s):
	n = 0
	while (ord(s[n]) != 0):
		n = n + 1
	return s[0:n]

def load_s3o_file(s3o_filename, BATCH_LOAD=False):
	if(BPyMessages.Error_NoFile(s3o_filename)):
		return

	print ""
	print "loading " + s3o_filename

	try:
		file = open(s3o_filename, "rb")
	except IOError:
		print "cannot open " + s3o_filename + " for reading"
		return

	Window.WaitCursor(1)
	header = s3o_header()
	header.load(file)
	print "loaded header"
	# setup springMAT material
	mat = Material.New('SpringMat')
	mat.rgbCol = [ 1.0, 1.0, 1.0 ]
	mat.setAlpha(1.0)
	mat.emit = 0.0
	mat.setSpec(0.0)
	image = None
	if(header.texture1):
		# load texture...
		tex = Texture.New()
		tex.setName('SpringTex1');
		print "loading texture '" + header.texture1 + "' ..."
		try:
			dirname = os.path.dirname(s3o_filename)
			image = Image.Load(dirname + "/../unittextures/" + header.texture1)
		except IOError:
			print "Unable to load " + header.texture1
		tex.setType('Image')
		tex.image = image
		tex.useAlpha = 0
		mat.setTexture(0, tex, Texture.TexCo.UV, Texture.MapTo.COL)
	image2 = None
	if(header.texture2):
		tex = Texture.New()
		tex.setName('SpringTex2');
		print "loading texture '" + header.texture2 + "' ..."
		try:
			dirname = os.path.dirname(s3o_filename)
			image2 = Image.Load(dirname + "/../unittextures/" + header.texture2)
		except IOError:
			print "Unable to load " + header.texture2
		tex.setType('Image')
		tex.image = image2
		tex.useAlpha = 0
		mat.setTexture(1, tex, Texture.TexCo.UV, Texture.MapTo.ALPHA)

	rootPiece = s3o_piece()
	rootPiece.load(file, header.rootPieceOffset, mat)
	rootPiece.ob.setEuler(math.pi/2.0, 0.0, 0.0)	# rotate 90 degrees on x axis
	# create collision sphere
	scn = Blender.Scene.GetCurrent()
	colsphere = scn.objects.new('Empty')
	colsphere.emptyShape = Object.EmptyShapes.SPHERE
	colsphere.drawSize = 1.0
	colsphere.setSize(header.radius,header.radius,header.radius)
	colsphere.setLocation(header.midx,header.midz,header.midy);
	colsphere.setName('SpringRadius')

	heightbox = scn.objects.new('Empty')
	heightbox.emptyShape = Object.EmptyShapes.ARROW
	heightbox.drawSize = 10.0
	heightbox.setLocation(header.midx, header.midz, header.height);
	heightbox.setName('SpringHeight')

	print "done"
	file.close()
	Window.WaitCursor(0)
	return

Window.FileSelector(load_s3o_file, 'Import a Spring S3O', '*.s3o')
