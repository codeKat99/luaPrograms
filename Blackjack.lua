--[[
    Blackjack.lua
    By: Jacob Soto and Joe Katalinich
    Blackjack game
]]

-- Card object
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
printSelf = function(self)
    if(self.face =="none") then io.write(self.value, " of ", self.suit)
    else io.write(self.face, " of ", self.suit)
    end
end
}


function Card:new (cardObj)
    cardObj = cardObj or {}   -- create object if user does not provide one
    setmetatable(cardObj, self) -- In this case, we are making
    self.__index = self
    return cardObj
  end


--Deck object, contains methods:
-- printDeck, makeDeck, and shuffleDeck
Deck = { 
    deckCards = {},
    cardsInDeck = 0,
    totalCards=52,
    suits = {"Spades", "Diamonds", "Hearts", "Clubs"},
    face = {"King", "Queen", "Jack"},
   
--Deck is initialized with a card from each suit starting from Ace->King
makeDeck = function (self)

    for i=1, 13, 1 do
        for key, suitValue in pairs(self.suits) do
            self.cardsInDeck = self.cardsInDeck + 1

            if(i==1) then self.deckCards[self.cardsInDeck] = Card:new{value=11, suit=suitValue, face="Ace"}
            elseif(i>1 and i<=10) then self.deckCards[self.cardsInDeck]= Card:new{value=i, suit=suitValue, face="none"}
            elseif(i==11) then self.deckCards[self.cardsInDeck]=Card:new{value=10, suit=suitValue, face="Jack"}
            elseif(i==12) then self.deckCards[self.cardsInDeck]=Card:new{value=10, suit=suitValue, face="Queen"}
            else self.deckCards[self.cardsInDeck]=Card:new{value=10, suit=suitValue, face="King"} end
        end
    end
    io.write("\nNew Deck Created with ", self.cardsInDeck, " cards")
    self:shuffleDeck()
end,

-- Creates a temp Deck and populates each index with a random card from the original Deck
-- Points original Deck to the temp Deck
shuffleDeck = function (self)
    local tempDeck = {}
    local shuffleCount = 0

    for j=1, 6, 1 do
        local tempCount = self.cardsInDeck
        shuffleCount = shuffleCount + 1

        for i=1, self.cardsInDeck, 1 do
            math.randomseed(os.time() * os.time())
            local index = math.random(tempCount);
            table.insert(tempDeck, i, table.remove(self.deckCards, index))
            tempCount = tempCount - 1
        end
        self.deckCards = tempDeck
    end

end,

-- If there are < 12 cards in the deck, make a new shuffled deck
checkDeck = function (self)
    if (self.cardsInDeck < 12) then self:makeDeck() end
end,

printDeck = function (self)
    for i=1, self.cardsInDeck, 1 do 
        self.deckCards[i]:printSelf()
        io.write( " " ,i, "\n")
    end

end
}

--"Default constructor"
function Deck:new (deckObj)
    deckObj = deckObj or {}
    setmetatable(deckObj, self)
    self.__index = self
    deckObj:makeDeck()
    return deckObj
end


Hand = {
    handObj = {}, -- if you don't override this, it can be a reference (BAD!)
    cardsInHand = 0,
    totalValue = 0,

    --Checks if the deck needs to be shuffled first, then inserts
    -- a card into the players hand from the top of the deck
    addCard = function(self, theDeck)
        theDeck:checkDeck()
        self.cardsInHand = self.cardsInHand + 1
        table.insert(self.handObj, self.cardsInHand, table.remove(theDeck.deckCards, 1)) --insert (Table you're writing into, index, new value)
        theDeck.cardsInDeck = theDeck.cardsInDeck - 1
        self.totalValue = self.totalValue + self.handObj[self.cardsInHand].value
    end,

    --Inserts cards from players hand back into the end of the deck
    returnCardsToDeck = function(self, theDeck)
        for index, card in pairs(self.handObj) do
            theDeck.cardsInDeck = theDeck.cardsInDeck + 1
            table.insert(theDeck.deckCards, theDeck.cardsInDeck, card) --insert (Table you're writing into, index, new value)
        end
        self.handObj = {}
        self.cardsInHand=0
        self.totalValue = 0
    end,

    -- Prints the value 
    calcHandValue = function(self)
        local tempVal = 0
        for i=1, self.cardsInHand, 1 do
            tempVal = tempVal + self.handObj[i].value
        end
        self.totalValue = tempVal
        
        if self.totalValue == 21 then print("Blackjack!!")
        elseif self.totalValue > 21 then print("Bust!!")
        else io.write("Total Hand Value = ", self:calcHandValue()) end
        print()
    end,


    -- Prints the value of each card in the players hand 
    showHand = function(self)
        for key, value in pairs(self.handObj) do
            value:printSelf();
            print();
        end
        self:calcHandValue()

    end

}

-- Hand object, contains a table of cards
function Hand:new (handObj)
    handObj = handObj or {}
    setmetatable(handObj, self)
    self.__index = self
    return handObj
end



Game = { -- a game table that holds functions related to managing the hands
    startNewRound = function(deck,...) -- version that accepts a variable number of Hand objects, not stored in a table

        local hands = {...}
        io.write("Returning the cards of " .. #hands .. " hands.\n" )
        for index, hand in pairs(hands) do
            hand:returnCardsToDeck(deck)
            deck:shuffleDeck()
        end
        deck:shuffleDeck()
    end,
    startNewRoundTableVers = function(deck,hands) --version that expects a Table of Hand Objects

        io.write("Returning the cards of " .. #hands .. " hands.\n" )
        for index, hand in pairs(hands) do
            hand:returnCardsToDeck(deck)
            deck:shuffleDeck()
        end
        deck:shuffleDeck()
    end

}

local newDeck = Deck:new{}
print("\nHow many other players do you want? There are always you and the dealer. There can be up to 3 more");
print("Input 1, 2, or 3")
NumPlayers = io.read()
if (NumPlayers ~= "1" and NumPlayers ~= "2" and NumPlayers ~= "3"  )then NumPlayers = 2
else NumPlayers = NumPlayers + 2 -- number of players is min 2 + the number provided
end
local playerTable = {}

--
function nameAndCards(self)
    io.write("\n" .. self.name .. " has:" )
    for key, card in pairs(self.handObj) do 
        card:printSelf()
        io.write(", ")
    end
    io.write("Total value: " .. self.totalValue .. "\n" )
end
for i=1, NumPlayers,1 do
    playerTable[i] = Hand:new{handObj={}, cardsInHand = 0, totalValue = 0, showNameAndCards = nameAndCards} -- initalize new hands. We are making a slightly new version of hands that includes showNameAndCards function
    if (i==1) then playerTable[i].name = "Human Player (You)" -- slightly new version of  Hand also includes the player names
    elseif(i==2) then playerTable[i].name = "Dealer"
    else playerTable[i].name = "Player " .. i
    end
end
nextMove = ""
print("\nYou're now playing blackjack!")
while (nextMove~="quit") do
    for index, player in pairs(playerTable) do
        player:addCard(newDeck) -- deal two cards
        player:addCard(newDeck)
        if(playerTable.name == "Dealer") then player.handObj[1]:printSelf() -- dealer only shows one card
        else player:showNameAndCards()
        end
    end
    print("The other players are drawing cards..")
    for index, player in pairs(playerTable) do -- if the player has a bad hand, keep drawing until it's too risky
        if(player.name~="Human Player (You)") then
            while (player.totalValue < 13) do
                player:addCard(newDeck)
            end
        end
    end

    while (playerTable[1].totalValue <= 21 and nextMove ~="quit") do -- player's while loop
        print("\nHit or stay?")
        if(nextMove == "hit") then 
            playerTable[1]:addCard(newDeck)
            playerTable[1]:showNameAndCards() -- draw a card and show new hand
            if(playerTable[1].totalValue > 21) then 
                io.write("BUSTED-------------\nYou are all getting new hands...")
                Game.startNewRoundTableVers(newDeck, playerTable)
                for index, player in pairs(playerTable) do
                    player:addCard(newDeck) -- deal two cards
                    player:addCard(newDeck)
                    if(playerTable.name == "Dealer") then player.handObj[1]:printSelf() -- dealer only shows one card
                    else player:showNameAndCards()
                    end
                end
            end
        end
        if(nextMove == "stay") then  -- keep what you've got and see if you won
            currentBestPlayer = {value = 0, index = 0 } -- check who is the best player
            for index, player in pairs(playerTable) do
                if (player.totalValue > currentBestPlayer.value and player.totalValue<22) then -- if you busted you can't win
                    currentBestPlayer.value = player.totalValue
                    currentBestPlayer.index = index
                end
            end
            if(currentBestPlayer.index ~=1) then
                print("You lost! Here was the best player's hand")
                playerTable[currentBestPlayer.index]:showNameAndCards()
                print("Here were your cards: ")
                playerTable[1]:showNameAndCards()
            else 
                print("YOU WON!")
                print("Here were your cards: ")
                playerTable[1]:showNameAndCards()
            end
            io.write("You and the dealer are getting new hands...")
            Game.startNewRoundTableVers(newDeck, playerTable) -- clear out all of the hands
            for index, player in pairs(playerTable) do
                player:addCard(newDeck) -- deal two cards
                player:addCard(newDeck)
                if(playerTable.name == "Dealer") then player.handObj[1]:printSelf() -- dealer only shows one card
                else player:showNameAndCards()
                end
            end
            end
            print("What's your next move?\n")
            nextMove = io.read()
            end
        end


