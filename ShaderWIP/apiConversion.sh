^((.|\n)*?)(?P<Spring>(Spring\.))(?P<FunctionName>\w+)([\s\n]+?\(\s?+)(?<ArgPair>(\s?+)(?<ArgType>\w+)(\s+)(?<ArgName>\w+)(\s?+(\,)?\s?+))?(?&ArgPair)?(\))([^>]+>\s?)(?P<ReturnType>\w+)([^\S]+)(?P<ReturnValue>\w+)(?<anyWS>(\s|\n|\r)+)


\g<Spring>\g<FunctionName>= function \g<FunctionName>(\g<ArgPair>) assert(type(\g<ArgName>) =="\g<ArgType>"); return Mock\g<ReturnType> end \n\n


^((.|\n)*?)(?P<Spring>(Spring\.))
(?P<FunctionName>\w+)([\s\n]+?\(\s?+)
(?P<ArgPair>(\s?+)(?P<ArgType>\w+)(\s+)(?P<ArgName>\w+)(\s?+(\,)?\s?+))?
(?&ArgPair)?
(\))
([^>]+\>)
(?P<RetArgPair>(\s?+)(?P<RetArgType>\w+)(\s+)(?P<RetArgName>\w+)(?P<Coma>\s?+(\,)?\s?+)?)??(?&RetArgPair)?(.+)
