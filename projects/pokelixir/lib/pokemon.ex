defmodule Pokemon do
  @enforce_keys [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defense,
    :speed,
    :height,
    :weight,
    :types
  ]
  defstruct @enforce_keys ++ []
end
