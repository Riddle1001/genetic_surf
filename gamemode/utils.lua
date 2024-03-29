function filter(array, fn)
    if not fn then return array end
    local new_array = {}
    for i, v in ipairs(array) do
        if fn(v) then
            table.insert(new_array, v)
        end
    end
    return new_array
end

function map(n, n_min, n_max, m_min, m_max)
    return (n - n_min) * (m_max - m_min) / (n_max - n_min) + m_min
end

local function sort_by_fitness(a, b) if a and b then return a:CalcFitness() > b:CalcFitness() end end

local me = function()
    for k, v in pairs(player.GetAll()) do
        if not v:IsBot() then
            return v
        end
    end
end