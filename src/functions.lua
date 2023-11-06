function Gx_Notify(text, x, y, z)
  	ESX.ShowFloatingHelpNotification(text, vector3(x, y, z+1.00))
end







lib.registerContext({
    id = 'boss_menu',
    title = 'Some context menu',
    options = {
      {
        title = 'Empty button',
      },
      {
        title = 'Disabled button',
        description = 'This button is disabled',
        icon = 'hand',
        disabled = true
      },
      {
        title = 'Example button',
        description = 'Example button description',
        icon = 'circle',
        onSelect = function()
          print("Pressed the button!")
        end,
        metadata = {
          {label = 'Value 1', value = 'Some value'},
          {label = 'Value 2', value = 300}
        },
      },
      {
        title = 'Menu button',
        description = 'Takes you to another menu!',
        menu = 'other_menu',
        icon = 'bars'
      },
      {
        title = 'Event button',
        description = 'Open a menu from the event and send event data',
        icon = 'check',
        event = 'test_event',
        arrow = true,
        args = {
          someValue = 500
        }
      }
    }
  })