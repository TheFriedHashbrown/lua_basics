local function Pet(name)
    return {
    name = name or "Charlie",
    status = "hungry",

    speak = function(self)
        print("Meow")
    end,

    feed = function(self)
        print(self.name .. " is Eating")
    end
    }
end

local jesse = Pet("jesse")

print(jesse.name)
jesse:speak()
jesse:feed()

local function Dog(name, breed)
    local dog = Pet(name)
    
    dog.breed = breed or "Doberman"

    dog.speak = function (self)
        print("woof")
    end

    return dog
end

local arby = Dog("arby")
print(arby.name)
arby:speak()