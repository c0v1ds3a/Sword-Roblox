-- Create a new Part object for the sword
local sword = Instance.new("Part")

-- Set the sword's properties
sword.Name = "Myc0v1dSword"
sword.Size = Vector3.new(2,2,10)
sword.Position = Vector3.new(0,5,0)
sword.Anchored = true
sword.CanCollide = true

-- Create a new Handle object for the sword handle
local handle = Instance.new("Handle")

-- Set the handle's properties
handle.Name = "MyHandle"
handle.Position = Vector3.new(0,5,0)

-- Connect the handle to the sword
handle.Part0 = sword
handle.C0 = CFrame.new(0,0,-5) * CFrame.Angles(0,0,math.rad(90))

-- Create a new Weld object to connect the sword to the player's character
local weld = Instance.new("Weld")

-- Set the weld's properties
weld.Name = "MyWeld"
weld.Part0 = sword
weld.C0 = CFrame.new(0,0,-5) * CFrame.Angles(0,0,math.rad(90))

-- Function to handle sword attacks
local function onAttack()
    -- Get the player's character
    local character = game.Players.LocalPlayer.Character

    -- Get the sword's handle
    local handle = character:FindFirstChild("MyHandle")

    -- Check if the handle exists
    if handle then
        -- Get the sword
        local sword = handle.Part1

        -- Check if the sword exists
        if sword then
            -- Get the sword's position and direction
            local position = sword.Position
            local direction = (handle.Position - position).Unit

            -- Create a ray that starts at the sword's position and extends in the direction of the handle
            local ray = Ray.new(position, direction)

            -- Check if the ray hits anything
            local hit, position, normal = game.Workspace:FindPartOnRay(ray, character)
            if hit then
                -- Create a new explosion at the hit position
                local explosion = Instance.new("Explosion")
                explosion.Position = position
                explosion.Parent = game.Workspace

                -- Destroy the hit object
                hit:Destroy()
            end
        end
    end
end

-- Bind the attack function to the player's attack button
game.Players.LocalPlayer.Attack.OnServerEvent:Connect(onAttack)
