print("Here")

file = io.open("C:/Users/thefi/Desktop/F Zone/2022-1 Spring Semester/IT 327/LuaProject/WordCount/Matthew.txt", "r")
lines = file:lines()

function split (inputstr, sep)
    if sep == nil then
            sep = "%s" -- %s is whitespace in lua
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

tab = split("Split me up boss", " ")
for i, v in pairs(tab) do
    print(i .. " " .. v)
end
wordCount = {}

function manageWords (wordTable, word)
    if wordTable[word] ~= nil then
        wordTable[word] = wordTable[word] + 1
    else wordTable[word] = 1
    end
end


print("Contents of file:");
for line in lines do
    words = split(line, " ")
    for i, v in pairs(words) do
        first,last = string.find(v,"%w*'?%w?")
        if first ~=nil and last~=nil then
            fixedWord = string.sub(v,first,last)
            manageWords(wordCount,fixedWord)
    end
    end
    print("\n")
end

for key,value in pairs(wordCount) do
    print(key .. " appeared " .. value .. " times!")
end