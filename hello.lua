temp = true
if temp then
    a=15  -- Notice that when we mouse over this, it is actually a global variable! Will be demonstrated below
    local b = 66
    temp=false
    myFun = function() print(a + "2") end
    myFun2 = function() print(a .. "2") end
end
print(a)
print("Oops, this won't work!", b) -- b is nil because we specifically declared it local.
myFun() -- since we're using the + operator, "2" will be coerced to 2.0
myFun2() -- since we're using the .. concatenation operator, Lua will try to coerce a to "15"