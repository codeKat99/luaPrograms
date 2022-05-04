print("Hello World")

temp = true
if temp then
    a=15  -- Notice that when we mouse over this, it is actually a global variable! Will be demonstrated below
    local b = 66
    temp=false
end

print("Hello world" , a)
print("Oops, this won't work!", b) -- b is nil because we specifically declared it local.

printMe = function() print("Hello there") end
printMe = function(hi) print(hi) end
printMe()
printMe("Hi")