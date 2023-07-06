defprotocol Character do
  def can_attack?(character, origin, target)
end

defimpl Character, for: Barbarian do
  def can_attack?(_character, origin, target) do
    {ox, oy} = origin
    {tx, ty} = target
    x_dist = if ox < tx, do: tx - ox, else: ox - tx
    y_dist = if oy < ty, do: ty - oy, else: oy - ty
    x_dist <= 2 and y_dist <= 2
  end
end

defimpl Character, for: Wizard do
  def can_attack?(_character, origin, target) do
    {ox, oy} = origin
    {tx, ty} = target
    x_dist = if ox < tx, do: tx - ox, else: ox - tx
    y_dist = if oy < ty, do: ty - oy, else: oy - ty
    x_dist === y_dist || ox === tx || oy === ty
  end
end

defimpl Character, for: Archer do
  def can_attack?(_character, origin, target) do
    {ox, oy} = origin
    {tx, ty} = target
    x_dist = if ox < tx, do: tx - ox, else: ox - tx
    y_dist = if oy < ty, do: ty - oy, else: oy - ty
    x_dist == 3 and y_dist == 3
  end
end
