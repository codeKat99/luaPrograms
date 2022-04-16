--[[
    Blackjack.lua
    By: Jacob Soto and Joe Katalinich
    Blackjack game - Object's file
]]


Card = { 
    value=0,
    suit="",
    face="",
showValue = function (self)
    print(self.value)
end,
showSuit = function (self)
    print(self.suit)
end,
showFace = function (self)
    print(self.face)
end,
--[[
printSelf = function (self)
    if(self.value > 1 and self.value<10) do print("I am a " + self.value + "of " + self.suit)
    else 
    end
]]
}

TableThatActsLikeAnObject = {
    myInt = 1,
    myDouble = 2.5,
    addMyStuff = function (self)
        myTotal = self.myInt + self.myDouble
        print("Wow, my total adds up to " + myTotal)
        return myTotal
    end
}




function Card:new (cardObj)
    cardObj = cardObj or {}   -- create object if user does not provide one
    setmetatable(cardObj, self) -- In this case, we are making
    self.__index = self
    return cardObj
  end

joker = Card:new{value = 5, suit = "Spade", face = "King"}
joker:showValue()

Deck = { 
    deckCards = {},
    totalCards=52,
    suits = {"Spades", "Diamonds", "Hearts", "Clubs"},
    face = {"King", "Queen", "Jack"},

    
--for loops, cycle through values of each suit        
makeDeck = function (self)
    for key,value in pairs(self.suits) do
        for i= 1,13,1 do
            if(i==1)      then self.deckCards[i*key]= Card:new{value=11, suit=value, face="Ace"}
            elseif(i<=10) then self.deckCards[i*key]= Card:new{value=i, suit=value, face="none"}
            elseif(i==11) then self.deckCards[i*key]=Card:new{value=10, suit=value, face="Jack"}
            elseif(i==12) then self.deckCards[i*key]=Card:new{value=10, suit=value, face="Queen"}
            else self.deckCards[i*key]=Card:new{value=10, suit=value, face="King"} 
            end
        end
    end
    print("New Deck Created")
    --self.deckCards.shuffleDeck()
end,
}

--[[
shuffleDeck = function (self)
    tempDeck = {},
    
    
    print("Deck has been shuffled")
end,

checkDeck = function (self)
    local count = 0
    for value in pairs(self.deckCards) do count = count + 1 end
    if(count < 13) then self.deckCards.makeDeck() end
end,
}
]]



function Deck:new (deckObj)
    deckObj = deckObj or {}
    setmetatable(deckObj, self)
    self.__index = self
    deckObj.makeDeck(deckObj)
    return deckObj
end

joker2 = Card:new{}
newDeck = Deck:new{}
--newDeck.makeDeck(newDeck)
print(newDeck.deckCards[3]:showSuit())






















































--[[

















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






























]]