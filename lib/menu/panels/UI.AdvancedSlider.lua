---@type table
local Slider = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 80 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30 },
    Header = { X = 215.5, Y = 15, Scale = 0.35 },
    Box = { X = 15, Y = 55, Width = 44.5, Height = 20.5 },
    SelectedRectangle = { X = 15, Y = 55, Width = 44.5, Height = 20.5 },
    Seperator = { Text = "/" }
}

---AdvancedSlider
---@param Title string
---@param Sliders thread
---@param MinimumIndex number
---@param CurrentIndex number
---@param Callback function
---@return nil
---@public
function RageUI.AdvancedSlider(Title, MaximumIndex, MinimumIndex, CurrentIndex, Action, Index, Style)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Index == Index) then

            ---@type number
            local Maximum = (MaximumIndex > 9) and 9 or MaximumIndex

            ---@type boolean
            local Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.Box.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, (Slider.Box.Width * Maximum), Slider.Box.Height)

            ---@type number
            local LeftArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.LeftArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height)

            ---@type number
            local RightArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.RightArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height)

            ---@type boolean
            local Selected = false

            RenderSprite(Slider.Background.Dictionary, Slider.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Slider.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.Background.Width + CurrentMenu.WidthOffset, Slider.Background.Height)
            RenderSprite(Slider.LeftArrow.Dictionary, Slider.LeftArrow.Texture, CurrentMenu.X + Slider.LeftArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height)
            RenderSprite(Slider.RightArrow.Dictionary, Slider.RightArrow.Texture, CurrentMenu.X + Slider.RightArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height)

            for Index = 1, Maximum do
                RenderRectangle(CurrentMenu.X + Slider.Box.X + (Slider.Box.Width * (Index - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.Box.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.Box.Width, Slider.Box.Height, 87, 87, 87, 255)
            end

            RenderRectangle(CurrentMenu.X + Slider.SelectedRectangle.X + (Slider.Box.Width * (CurrentIndex - MinimumIndex)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.SelectedRectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.SelectedRectangle.Width, Slider.SelectedRectangle.Height, 245, 245, 245, 255)

            local SliderSeperator = {}
            if type(Style) == "table" then
                if type(Style.Seperator) == "table" then
                    SliderSeperator = Style.Seperator
                else
                    SliderSeperator = Slider.Seperator
                end
            else
                SliderSeperator = Slider.Seperator
            end
            
            RenderText((Title and Title or "") .. " (" .. CurrentIndex .. " " .. SliderSeperator.Text .. " " .. MaximumIndex .. ")", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)

            if Hovered or LeftArrowHovered or RightArrowHovered then
                if RageUI.Settings.Controls.Click.Active then
                    Selected = true

                    if LeftArrowHovered then
                        CurrentIndex = CurrentIndex - 1

                        if CurrentIndex < 1 then
                            CurrentIndex = MaximumIndex
                            MinimumIndex = MaximumIndex - Maximum + 1
                        elseif CurrentIndex < MinimumIndex then
                            MinimumIndex = MinimumIndex - 1
                        end
                    elseif RightArrowHovered then
                        CurrentIndex = CurrentIndex + 1

                        if CurrentIndex > MaximumIndex then
                            CurrentIndex = 1
                            MinimumIndex = 1
                        elseif CurrentIndex > MinimumIndex + Maximum - 1 then
                            MinimumIndex = MinimumIndex + 1
                        end
                    elseif Hovered then
                        for Index = 1, Maximum do
                            if RageUI.IsMouseInBounds(CurrentMenu.X + Slider.Box.X + (Slider.Box.Width * (Index - 1)) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Slider.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.Box.Width, Slider.Box.Height) then
                                CurrentIndex = MinimumIndex + Index - 1
                            end
                        end
                    end

                    if (Action.onSliderChange ~= nil) then
                        Action.onSliderChange(MinimumIndex, CurrentIndex)
                    end
                end
            end

            RageUI.ItemOffset = RageUI.ItemOffset + Slider.Background.Height + Slider.Background.Y

            if (Hovered or LeftArrowHovered or RightArrowHovered) and RageUI.Settings.Controls.Click.Active then
                local Audio = RageUI.Settings.Audio
                RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
            end
        end
    end
end


