textfile = 'testfile.txt'
file = io.open(textfile, "r")
lines = file:lines()

function split (inputstr, sep)
    if sep == nil then
            sep = "%s" -- %s is whitespace in lua
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do -- We do a little regex!
            table.insert(t, str)
    end
    return t
end
--[[
tab = split("Split me up boss", " ")
for i, v in pairs(tab) do
    print(i .. " " .. v)
end

--]]
wordCount = {}
function manageWords (wordTable, word)
    if wordTable[word] ~= nil then
        wordTable[word] = wordTable[word] + 1
    else wordTable[word] = 1
    end
end

function topX(wordTable, numWords)
    local topXWords = {}
    for i=1, numWords,1 do
        local tempWordPair = {num=0, word=""}
        for word, count in pairs(wordTable) do
            if(topXWords[word]==nil and wordTable[word] > tempWordPair.num) then 
                tempWordPair.num = wordTable[word]
                tempWordPair.word=word
            end
        end
        topXWords[tempWordPair.word]=tempWordPair.num
        print(tempWordPair.word .. " appeared " .. tempWordPair.num .. " times!")
    end
    return topXWords
end
function bottomX(wordTable, numWords)
    local topXWords = {}
    for i=1, numWords,1 do
        local tempWordPair = {num=99999999, word=""}
        for word, count in pairs(wordTable) do
            if(topXWords[word]==nil and wordTable[word] < tempWordPair.num) then 
                tempWordPair.num = wordTable[word]
                tempWordPair.word=word
            end
        end
        topXWords[tempWordPair.word]=tempWordPair.num
        print(tempWordPair.word .. " appeared " .. tempWordPair.num .. " times!")
    end
    return topXWords
end
    


print("Reading in file...");
for line in lines do
    words = split(line, " ")
    for i, v in pairs(words) do
        first,last = string.find(v,"%w*'?%w?")
        if first ~=nil and last~=nil then
            fixedWord = string.sub(v,first,last)
            manageWords(wordCount,fixedWord)
    end
    end
    --print("\n")
end
--[[]
for key,value in pairs(wordCount) do
    print(key .. " appeared " .. value .. " times!")
end
--]]
print("Calling for function to see what the top X=10 most frequent words were in the text: ".. textfile );
topX(wordCount,10)
print("Calling for function to see what 5 most INFREQUENT words were in the text: ".. textfile );
bottomX(wordCount,5)