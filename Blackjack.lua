--[[
    Blackjack.lua
    By: Jacob Soto and Joe Katalinich
    Blackjack game - Object's file
]]

-- Card "object" 
Card = {  -- "Object" because it is stil just a table for now
    value=0, -- this lets us do Card.value = ...
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
    printSelf = function(self)
        if(self.face =="none") then io.write(self.value, " of ", self.suit)
        else io.write(self.face, " of ", self.suit)
    end
end
}
function Card:new (cardObj)
    cardObj = cardObj or {}   -- create object if user does not provide one
    setmetatable(cardObj, self) -- The original Card is the metatable for cardObj,
    self.__index = self -- The new cardObj will "inherit" any functions it doesn't have from Card
    return cardObj
  end
newCard = Card:new{suit="Spades",face="NewSuit"}
newCard.printSelf(newCard)
newCard:printSelf();

newCard2 = newCard:new{suit="Yes"}
newCard2:printSelf();

--Deck object, contains methods:
-- printDeck, makeDeck, and shuffleDeck
Deck = { 
    deckCards = {},
    totalCards=52,
    suits = {"Spades", "Diamonds", "Hearts", "Clubs"},
    face = {"King", "Queen", "Jack"},

printDeck = function (self)
    for i=1, self.totalCards, 1 do 
        self.deckCards[i]:printSelf()
        io.write( " " ,i, "\n")
    end
end,


-- Instantiates a deck with 4 cards of each value that contain a different suit       
makeDeck = function (self)
    count = 0
    for key,suitValue in pairs(self.suits) do
        for i= 1,13,1 do -- for int i =1; i<=13 ; i++
            count = count+1
            if(i==1)      then self.deckCards[(key-1)*13 + i]= Card:new{value=11, suit=suitValue, face="Ace"}
            elseif(i>1 and i<=10) then self.deckCards[(key-1)*13 + i]= Card:new{value=i, suit=suitValue, face="none"}
            elseif(i==11) then self.deckCards[(key-1)*13 + i]=Card:new{value=10, suit=suitValue, face="Jack"}
            elseif(i==12) then self.deckCards[(key-1)*13 + i]=Card:new{value=10, suit=suitValue, face="Queen"}
            else self.deckCards[(key-1)*13 + i]=Card:new{value=10, suit=suitValue, face="King"} 
            end
        end
    end
    print("\nNew Deck Created")
    self:shuffleDeck()
end,

-- Creates a temp Deck and populates each index with a random card from the original Deck
-- Points original Deck to the temp Deck
shuffleDeck = function (self)
    tempDeck = {self.totalCards}
    randIndex = 0
    cardsRemaining = self.totalCards
    counter = 0
    for i= 1,self.totalCards,1 do
        counter = counter +1
        math.randomseed(os.time()) 
        local randIndex = math.random(1, cardsRemaining)
        cardsRemaining = cardsRemaining-1
        tempDeck[i] = table.remove(self.deckCards, randIndex)
       
    end
    
    self.deckCards = tempDeck
    print("Deck has been shuffled")
    print("Counter: " , counter)
end,
}




function Deck:new (deckObj)
    deckObj = deckObj or {}
    setmetatable(deckObj, self)
    self.__index = self
    deckObj:makeDeck()
    return deckObj
end

joker2 = Card:new{}

newDeck = Deck:new{}


newDeck:printDeck()
--newDeck.makeDeck(newDeck)
--print( newDeck.deckCards[1]:printSelf())















































--[[


Table Reference:
TableThatActsLikeAnObject = {
    myInt = 1,
    myDouble = 2.5,
    addMyStuff = function (self)
        myTotal = self.myInt + self.myDouble
        print("Wow, my total adds up to " + myTotal)
        return myTotal
    end
}














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