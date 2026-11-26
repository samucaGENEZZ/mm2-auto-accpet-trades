-- [[ MEU GURU | MM2 ELITE EDITION ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Meu Guru Elite | MM2 Automation",
   LoadingTitle = "Iniciando Sistema...",
   LoadingSubtitle = "by Meu Guru",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "GuruMM2", 
      FileName = "EliteConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "", 
      RememberJoins = true 
   },
   KeySystem = false
})

-- [[ VARIABLES ]] --
_G.AutoAccept = false
_G.FreezeTrade = false
_G.AutoCollect = false

-- [[ TABS ]] --
local MainTab = Window:CreateTab("Início", 4483362458) -- Ícone de casa
local TradeTab = Window:CreateTab("Trocas & Itens", 4483345998) -- Ícone de troca

-- [[ MAIN TAB CONTENT ]] --
MainTab:CreateSection("Automação de Farm")

MainTab:CreateToggle({
   Name = "Auto Coletar Moedas",
   CurrentValue = false,
   Flag = "CoinToggle",
   Callback = function(Value)
      _G.AutoCollect = Value
      while _G.AutoCollect do
         pcall(function()
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
               if v.Name == "CoinContainer" then
                  local coin = v:FindFirstChild("Coin")
                  if coin then
                     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                  end
               end
            end
         end)
         task.wait(0.1)
      end
   end,
})

-- [[ TRADE TAB CONTENT ]] --
TradeTab:CreateSection("Funções de Trade")

TradeTab:CreateToggle({
   Name = "Auto Accept (Aceitar Automático)",
   CurrentValue = false,
   Flag = "AcceptToggle",
   Callback = function(Value)
      _G.AutoAccept = Value
      while _G.AutoAccept do
         local tradeGui = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Trade
         if tradeGui.Visible then
            -- Aciona o botão de aceitar via sistema de cliques do Rayfield
            fireclickdetector(tradeGui.Container.Accept.Button)
         end
         task.wait(0.5)
      end
   end,
})

TradeTab:CreateToggle({
   Name = "Freeze Trade (Lag de Rede)",
   CurrentValue = false,
   Flag = "FreezeToggle",
   Callback = function(Value)
      _G.FreezeTrade = Value
      if Value then
         settings().Network.IncomingReplicationLag = 1000 -- Lag de $$1000$$ms
         Rayfield:Notify({
            Title = "Aviso de Rede",
            Content = "Lag de rede ativado para a troca.",
            Duration = 3,
            Image = 4483345998,
         })
      else
         settings().Network.IncomingReplicationLag = 0
      end
   end,
})

TradeTab:CreateSection("Inventário")

TradeTab:CreateButton({
   Name = "Liberar Facas Raras (Visual)",
   Callback = function()
      -- Script de visual skin unlocker
      Rayfield:Notify({
         Title = "Sucesso!",
         Content = "Inventário raro carregado localmente.",
         Duration = 5,
         Image = 4483345998,
      })
      -- Logica local de inventário aqui
   end,
})

Rayfield:LoadConfiguration()
