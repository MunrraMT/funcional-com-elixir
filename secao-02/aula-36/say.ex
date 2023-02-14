defmodule MyModule.SaySomething do
  def hello_world do
    "Olá mundo!"
  end

  def hello_world(msg) do
    msg
  end
end

# múltiplas funções com mesmo nome, diferenciadas pela quantidade de aridade (parâmetros)
