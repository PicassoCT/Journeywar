

  local file = io.open("Newfile.lua","r")



if file then


    -- Opens a file in append mode
lineTable={}

keycount={}
keycount["aa"]={};
keycount["bb"]={};
keycount["cc"]={};
keycount["dd"]={};
keycount["ee"]={};
keycount["ff"]={};
keycount["gg"]={};


    keycount["aa"].nr=1;keycount["bb"].nr=2;keycount["cc"].nr=3;keycount["dd"].nr=4;keycount["ee"].nr=5;keycount["ff"].nr=6;keycount["gg"].nr=7

   assert(file)

    for line in file:lines() do
        print("Going through all lines")
        for k,v in pairs(keycount) do
            while string.find(line,k) do
            print("Match found")
            string.gsub(line, k, v.nr,2)
            v.nr=v.nr+7
            end
        end
    lineTable[#lineTable+1]=line
     end
 -- appends a word test to the last line of the file
io.close(file)
 appendix = io.open("output.c", "r+")
io.output(appendix)
for i=1,#lineTable do
io.write(lineTable[i])
end
 --do something with that data

else
print(" could not open file")
end
