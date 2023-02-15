# STRUCTS

defmodule MyModule.User do
  defstruct name: "Maria", age: "10 months"
end

defmodule MyModule.User2 do
  defstruct name: nil, age: nil
end

# usuario = %MyModule.User{name: "André", age: 32}
# %MyModule.User{name: "André", age: 32}

# usuario = %MyModule.User{usuario | name: "André Rodrigues"}
# %MyModule.User{name: "André Rodrigues", age: 32}

# usuario
# %MyModule.User{name: "André Rodrigues", age: 32}

defmodule MyModule.User3 do
  defstruct [:name, :age]
end

# usuario = %MyModule.User3{}
# %MyModule.User3{name: nil, age: nil}

# usuario = %MyModule.User3{name: "André"}
# %MyModule.User3{name: "André", age: nil}

defmodule MyModule.User4 do
  @enforce_keys [:name]
  defstruct [:name, :age]
end

# usuario = %MyModule.User4{}
# ** (ArgumentError) the following keys must also be given when building struct MyModule.User4: [:name]
#     expanding struct: MyModule.User4.__struct__/1

# usuario = %MyModule.User4{age: 32}
# ** (ArgumentError) the following keys must also be given when building struct MyModule.User4: [:name]
#     expanding struct: MyModule.User4.__struct__/1

# usuario = %MyModule.User4{name: "André"}
# %MyModule.User4{name: "André", age: nil}
