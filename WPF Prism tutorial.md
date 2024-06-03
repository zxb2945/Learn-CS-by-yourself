# WPF Prism tutorial

If you want to read markdown file,  I recommend you using Typora or visual studio code.



## 1.Create a new Prism Blank App(WPF)

> Prism provides full support for the MVVM (Model-View-ViewModel) pattern, helping developers to separate the application's logic from its UI, which enhances testability and maintainability.

Please refer to [here](https://docs.prismlibrary.com/docs/index.html), there is everything you want to know about prism.



## 2.Make a simple MainWindow.xaml

```xaml
<Window x:Class="BlankApp1.Views.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:prism="http://prismlibrary.com/"
        prism:ViewModelLocator.AutoWireViewModel="True"
        Title="{Binding Title}" Height="600" Width="500" >
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="6*"/>
        </Grid.RowDefinitions>
        <StackPanel Grid.Row="0" Margin="30" Orientation="Horizontal">
            <Button Content="ShogenCheckWindow"/>
            <Button Content="DTCreater"/>
        </StackPanel>
    </Grid>
</Window>
```



There are a lot of kinds of WPF controls, but the first control you need to know is **Layout component**. It has five kinds. Grid and StackPanel is most common.



## 3.ViewModelLocator

> The `ViewModelLocator` is used to wire the `DataContext` of a view to an instance of a ViewModel using a standard naming convention.

The switch is 

```
prism:ViewModelLocator.AutoWireViewModel="True"
```





## 4.DelegateCommand

```C#
//Snippets:
//1.propp - Property, with a backing field, that depends on BindableBase
//2.cmd - Creates a DelegateCommand property with Execute method
//3.cmdfull - Creates a DelegateCommand property with Execute and CanExecute methods
//4.cmdg - Creates a generic DelegateCommand property
//5.cmdgfull - Creates a generic DelegateCommand property with Execute and CanExecute methods

//=> Please use cmdfull to create a DelegateCommand template
private DelegateCommand _commandA;
public DelegateCommand CommandA =>
    _commandA ?? (_commandA = new DelegateCommand(ExecuteCommandA, CanExecuteCommandA));

void ExecuteCommandA()
{
    //Logic when you push the button
    MessageBox.Show("Hello world!");
}

bool CanExecuteCommandA()
{
    //Make Button disable / enable
    return true;
}
```

Maybe you need to install Extension for Visual Studio firstly:  Prism Template Pack



**Suggestion**: If you want to keep strict MVVM principle, use Command in ViewModel rather than Click event in View



## 5.Region Navigation

1. Add two User Controls for Checker and Creater xaml.

2. Register them in App.xaml 

   ```C#
           protected override void RegisterTypes(IContainerRegistry containerRegistry)
           {
               containerRegistry.RegisterForNavigation<Checker>();
               containerRegistry.RegisterForNavigation<Creater>();
           }
   ```

3. Apply Navigation function in MainWindow.xaml and MainWIndowViewModel.cs

   ```xaml
   <ContentControl Grid.Row="1" prism:RegionManager.RegionName="ContentRegion" />
   ```

   ```C#
    public class MainWindowViewModel : BindableBase
    {
        private string _title = "Prism Application";
        public string Title
        {
            get { return _title; }
            set { SetProperty(ref _title, value); }
   
        }
   
   
   
        private readonly IRegionManager _regionManager;
   
   
        public MainWindowViewModel(IRegionManager regionManager)
        {
            this._regionManager = regionManager;
        }
   
   
   
        private DelegateCommand _commandA;
        public DelegateCommand CommandA =>
            _commandA ?? (_commandA = new DelegateCommand(ExecuteCommandA, CanExecuteCommandA));
   
        void ExecuteCommandA()
        {
            //Logic
            
   
   
        }
   
        bool CanExecuteCommandA()
        {
            return true;
        }
   
   
   
        private DelegateCommand _commondB;
        public DelegateCommand CommandB =>
            _commondB ?? (_commondB = new DelegateCommand(ExecuteCommandB, CanExecuteCommandB));
   
        void ExecuteCommandB()
        {
            if (_regionManager != null)
            {
                _regionManager.RequestNavigate("ContentRegion", "Creater");
            }
        }
   
        bool CanExecuteCommandB()
        {
            return true;
        }
   
    }
   ```

4. Bind command  to Button to trigger Navigation



## 6.Dialog Service 

Refer to [Here](https://docs.prismlibrary.com/docs/platforms/xamarin-forms/dialogs/dialog-service.html)

1. Add a usercontrol for pop window

   ```xaml
   <UserControl x:Class="BlankApp1.Views.Popwindow"
                xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
                xmlns:local="clr-namespace:BlankApp1.Views"
                xmlns:prism="http://prismlibrary.com/"
                mc:Ignorable="d" 
                d:DesignHeight="450" d:DesignWidth="800">
       <prism:Dialog.WindowStyle>
           <Style TargetType="Window">
               <Setter Property="Width" Value="100"/>
               <Setter Property="Height" Value="200"/>
           </Style>
       </prism:Dialog.WindowStyle>
       <Grid>
           <TextBlock Text="I'm Pop"/>
       </Grid>
   </UserControl>
   ```

2. Register it in App.xaml 

   ```C#
           protected override void RegisterTypes(IContainerRegistry containerRegistry)
           {
               containerRegistry.RegisterForNavigation<Checker>();
               containerRegistry.RegisterForNavigation<Creater>();
   
               containerRegistry.RegisterDialog<Popwindow>();
           }
   ```

3. Apply Dialog Service  function inMainWIndowViewModel.cs

   ```C#
   namespace BlankApp1.ViewModels
   {
       public class MainWindowViewModel : BindableBase
       {
           private string _title = "Prism Application";
           public string Title
           {
               get { return _title; }
               set { SetProperty(ref _title, value); }
   
           }
   
   
   
           private readonly IRegionManager _regionManager;
           //Initial
           private readonly IDialogService dialogService;
   
   
           public MainWindowViewModel(IRegionManager regionManager, IDialogService dialog)
           {
               this._regionManager = regionManager;
                //Initial
               this.dialogService = dialog;
           }
   
   
   
           private DelegateCommand _commandA;
           public DelegateCommand CommandA =>
               _commandA ?? (_commandA = new DelegateCommand(ExecuteCommandA, CanExecuteCommandA));
   
           void ExecuteCommandA()
           {
               //Call Dialog
               IDialogParameters parameters = new DialogParameters();
               dialogService.ShowDialog("Popwindow", parameters, DialogCallback);
   
   
           }
   
           bool CanExecuteCommandA()
           {
               return true;
           }
   
           private void DialogCallback(IDialogResult result)
           {
               if (result.Result != ButtonResult.OK) return;
   
           }
      }
   }
   ```

4. Don't forget add ViewModel for it, otherwise it will throw a exception

   ```C#
   namespace BlankApp1.ViewModels
   {
       internal class PopwindowViewModel : IDialogAware
       {
           public string Title { get; set; }
   
           public event Action<IDialogResult> RequestClose;
   
           public bool CanCloseDialog()
           {
               //throw new NotImplementedException();
               return true;
           }
   
           public void OnDialogClosed()
           {
               //throw new NotImplementedException();
           }
   
           public void OnDialogOpened(IDialogParameters parameters)
           {
               //throw new NotImplementedException();
           }
       }
   }
   ```

   

##  7.Style Library

Actually it doesn't belong to Prism framework, it is just a sugar for WPF. Make the GUI beautiful overall easily.

There are lot of Libraries online, for example: MahApps.Metro UI Style Library

You can login the github to check the detail you need to know about it. [LINK](https://github.com/MahApps/MahApps.Metro/wiki/Quick-Start)

Follow these steps to use the MahApps.Metro style in your application.

**Add the resources in App.xaml (v2.0)**

```
<Application.Resources>
   <ResourceDictionary>
     <ResourceDictionary.MergedDictionaries>
       <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Controls.xaml" />
       <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Fonts.xaml" />
       <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Themes/Light.Blue.xaml" />
     </ResourceDictionary.MergedDictionaries>
   </ResourceDictionary>
</Application.Resources>
```

**Change Window to MetroWindow in your main window**

```xaml
<mah:MetroWindow x:Class="WpfApplication.MainWindow"
	                xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	                xmlns:mah="http://metro.mahapps.com/winfx/xaml/controls"
	                Title="MainWindow"
	                Height="600"
	                Width="800">
	<Grid>
	   <!-- your content -->
	</Grid>
</mah:MetroWindow>
```

