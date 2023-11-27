# 开源C# WPF控件库：MahApps.Metro  介绍

MahApps.Metro 项目仓库：[Here](https://github.com/MahApps/MahApps.Metro)

个人调试仓库：[GitHub](https://github.com/zxb2945/PlayWithWPF)

根据仓库例子，采用Prism的MvvM框架手动coding过一遍：

## 1 下载相应Nuget包

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>WinExe</OutputType>
    <TargetFramework>net6.0-windows</TargetFramework>
    <UseWPF>true</UseWPF>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="MahApps.Metro" Version="2.4.10" />
    <PackageReference Include="MahApps.Metro.IconPacks" Version="4.11.0" />
    <PackageReference Include="Prism.Unity" Version="8.1.97" />
  </ItemGroup>
</Project>
```

## 2 App.xaml

```xaml
<prism:PrismApplication x:Class="PlayWithMahApps.MetroForWork.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:PlayWithMahApps.MetroForWork"
             xmlns:prism="http://prismlibrary.com/" >
    <Application.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Controls.xaml" />
                <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Fonts.xaml" />
                <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Themes/Light.Blue.xaml" />
            </ResourceDictionary.MergedDictionaries>
        </ResourceDictionary>
    </Application.Resources>
</prism:PrismApplication>
```

## 3 MainWindow.xaml

```xaml
<mah:MetroWindow x:Class="PlayWithMahApps.MetroForWork.Views.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:mah="http://metro.mahapps.com/winfx/xaml/controls"
        xmlns:iconPacks="http://metro.mahapps.com/winfx/xaml/iconpacks"                 
        xmlns:prism="http://prismlibrary.com/" 
        xmlns:local="clr-namespace:PlayWithMahApps.MetroForWork.Views"         
        prism:ViewModelLocator.AutoWireViewModel="True"
        Width="1024"
        Height="768"
        MinWidth="800"
        MinHeight="600" 
        Title="{Binding Title}">
    <Window.Resources>
        <ResourceDictionary>
            <Ellipse x:Key="AppThemeMenuIcon"
                     Width="16"
                     Height="16"
                     x:Shared="False"
                     Fill="{Binding ColorBrush, Mode=OneWay}"
                     Stroke="{Binding BorderColorBrush, Mode=OneWay}"
                     StrokeThickness="1" />
            <Ellipse x:Key="AccentMenuIcon"
                     Width="16"
                     Height="16"
                     x:Shared="False"
                     Fill="{Binding ColorBrush, Mode=OneWay}" />

            <Style x:Key="AppThemeMenuItemStyle"
                   BasedOn="{StaticResource MahApps.Styles.MenuItem}"
                   TargetType="{x:Type MenuItem}">
                <Setter Property="Command" Value="{Binding ChangeAccentCommand}" />
                <Setter Property="CommandParameter" Value="{Binding Name, Mode=OneWay}" />
                <Setter Property="Header" Value="{Binding Name, Mode=OneWay}" />
                <Setter Property="Icon" Value="{StaticResource AppThemeMenuIcon}" />
            </Style>

            <Style x:Key="AccentColorMenuItemStyle"
                   BasedOn="{StaticResource MahApps.Styles.MenuItem}"
                   TargetType="{x:Type MenuItem}">
                <Setter Property="Command" Value="{Binding ChangeAccentCommand}" />
                <Setter Property="CommandParameter" Value="{Binding Name, Mode=OneWay}" />
                <Setter Property="Header" Value="{Binding Name, Mode=OneWay}" />
                <Setter Property="Icon" Value="{StaticResource AccentMenuIcon}" />
            </Style>

            <!--  This is the template for the option menu item  -->
            <DataTemplate x:Key="HamburgerOptionsMenuItem" DataType="{x:Type mah:HamburgerMenuIconItem}">
                <DockPanel Height="48" LastChildFill="True">
                    <ContentControl x:Name="IconPart"
                                    Width="{Binding RelativeSource={RelativeSource AncestorType={x:Type mah:HamburgerMenu}}, Path=CompactPaneLength}"
                                    Content="{Binding Icon}"
                                    DockPanel.Dock="Left"
                                    Focusable="False"
                                    IsTabStop="False" />
                    <TextBlock x:Name="TextPart"
                               VerticalAlignment="Center"
                               FontSize="16"
                               Text="{Binding Label}" />
                </DockPanel>
                <DataTemplate.Triggers>
                    <DataTrigger Binding="{Binding RelativeSource={RelativeSource AncestorType={x:Type mah:HamburgerMenu}}, Path=PanePlacement}" Value="Right">
                        <Setter TargetName="IconPart" Property="DockPanel.Dock" Value="Right" />
                        <Setter TargetName="TextPart" Property="Margin" Value="8 0 0 0" />
                    </DataTrigger>
                </DataTemplate.Triggers>
            </DataTemplate>

        </ResourceDictionary>
    </Window.Resources>

    <!--How to set window icon from iconpack-->
    <!--use the IconTemplate property to set a custom Icon at the title bar.-->
    <!--https://github.com/MahApps/MahApps.Metro/issues/3464-->
    <mah:MetroWindow.IconTemplate>
        <DataTemplate>
            <iconPacks:PackIconModern Width="{TemplateBinding Width}"
                                      Height="{TemplateBinding Height}"
                                      Margin="4"
                                      Foreground="{DynamicResource IdealForegroundColorBrush}"
                                      Kind="Box" />
        </DataTemplate>
    </mah:MetroWindow.IconTemplate>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto" />
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>

        <Menu Grid.Row="0"
              Margin="5"
              HorizontalAlignment="Left"
              VerticalAlignment="Stretch">
            <MenuItem Header="Theme"
                      ItemContainerStyle="{StaticResource AppThemeMenuItemStyle}"
                      ItemsSource="{Binding AppThemes, Mode=OneWay}" />
            <MenuItem Header="Accent"
                      ItemContainerStyle="{StaticResource AccentColorMenuItemStyle}"
                      ItemsSource="{Binding AccentColors, Mode=OneWay}" />
        </Menu>

        <Border Grid.Row="1"
                BorderBrush="{DynamicResource MahApps.Brushes.Gray7}"
                BorderThickness="1">

            <mah:HamburgerMenu x:Name="HamburgerMenuControl"
                               DisplayMode="CompactOverlay"
                               HamburgerWidth="48"
                               IsPaneOpen="{Binding IsHamburgerMenuPaneOpen}"
                               ItemInvoked="HamburgerMenuControl_OnItemInvoked"
                               ItemTemplate="{StaticResource HamburgerOptionsMenuItem}"
                               SelectedIndex="1"
                               VerticalScrollBarOnLeftSide="False">

                <!--  Items  -->
                <mah:HamburgerMenu.ItemsSource>
                    <mah:HamburgerMenuItemCollection>

                        <mah:HamburgerMenuIconItem x:Name="AboutOption"
                                                   Command="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType=mah:HamburgerMenu}, Path=DataContext.ShowHamburgerAboutCommand}"
                                                   Label="HelloDR">
                            <mah:HamburgerMenuIconItem.Icon>
                                <iconPacks:PackIconMaterial Width="22"
                                                            Height="22"
                                                            HorizontalAlignment="Center"
                                                            VerticalAlignment="Center"
                                                            Kind="TransmissionTower" />
                            </mah:HamburgerMenuIconItem.Icon>
                            <mah:HamburgerMenuIconItem.Tag>
                                <local:DRWindows DataContext="{Binding}" />
                            </mah:HamburgerMenuIconItem.Tag>
                        </mah:HamburgerMenuIconItem>
                        
                        <mah:HamburgerMenuIconItem x:Name="AboutOption2"
                                                   Command="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType=mah:HamburgerMenu}, Path=DataContext.ShowHamburgerAboutCommand}"
                                                   Label="HelloNR">
                            <mah:HamburgerMenuIconItem.Icon>
                                <!--  iconPacks need to be downloaded through Nuget, and icon by kind property-->
                                <iconPacks:PackIconMaterial Width="22"
                                                            Height="22"
                                                            HorizontalAlignment="Center"
                                                            VerticalAlignment="Center"
                                                            Kind="Signal5g" />
                            </mah:HamburgerMenuIconItem.Icon>
                            <mah:HamburgerMenuIconItem.Tag>
                                <!--  it could be placed any type here  -->
                                <local:NRWindows DataContext="{Binding}" />
                            </mah:HamburgerMenuIconItem.Tag>
                        </mah:HamburgerMenuIconItem>


                        <mah:HamburgerMenuIconItem x:Name="AboutOption3"
                                                   Command="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType=mah:HamburgerMenu}, Path=DataContext.ShowHamburgerAboutCommand}"
                                                   Label="HelloNR">
                            <mah:HamburgerMenuIconItem.Icon>
                                <iconPacks:PackIconMaterial Width="22"
                                                            Height="22"
                                                            HorizontalAlignment="Center"
                                                            VerticalAlignment="Center"
                                                            Kind="SignalCellular1" />
                            </mah:HamburgerMenuIconItem.Icon>
                            <mah:HamburgerMenuIconItem.Tag>
                                <local:NRWindows DataContext="{Binding}" />
                            </mah:HamburgerMenuIconItem.Tag>
                        </mah:HamburgerMenuIconItem>

                    </mah:HamburgerMenuItemCollection>
                </mah:HamburgerMenu.ItemsSource>


                <!--  Content  -->
                <mah:HamburgerMenu.ContentTemplate>
                    <DataTemplate>
                        <Grid x:Name="ContentGrid">
                            <Grid.RowDefinitions>
                                <RowDefinition />
                            </Grid.RowDefinitions>
                            <mah:TransitioningContentControl Grid.Row="0"
                                                             Content="{Binding}"
                                                             RestartTransitionOnContentChange="True"
                                                             Transition="Default">
                                <mah:TransitioningContentControl.Resources>
                                    <DataTemplate DataType="{x:Type mah:HamburgerMenuIconItem}">
                                        <ContentControl Content="{Binding Tag, Mode=OneWay}"
                                                        Focusable="True"
                                                        IsTabStop="False" />
                                    </DataTemplate>
                                </mah:TransitioningContentControl.Resources>
                            </mah:TransitioningContentControl>
                        </Grid>
                    </DataTemplate>
                </mah:HamburgerMenu.ContentTemplate>
            </mah:HamburgerMenu>
        </Border>

    </Grid>
</mah:MetroWindow>

```

MainWindow.xaml.cs

```C#
using MahApps.Metro.Controls;
using System.Windows;

namespace PlayWithMahApps.MetroForWork.Views
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void HamburgerMenuControl_OnItemInvoked(object sender, HamburgerMenuItemInvokedEventArgs e)
        {
            this.HamburgerMenuControl.Content = e.InvokedItem;

            if (!e.IsItemOptions && this.HamburgerMenuControl.IsPaneOpen)
            {
                // close the menu if a item was selected
                this.HamburgerMenuControl.IsPaneOpen = false;
            }
        }

    }
}
```

## 4 DRWindows.xaml

```xaml
<UserControl x:Class="PlayWithMahApps.MetroForWork.Views.DRWindows"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:PlayWithMahApps.MetroForWork.Views"
             xmlns:mah="http://metro.mahapps.com/winfx/xaml/controls"
             xmlns:iconPacks="http://metro.mahapps.com/winfx/xaml/iconpacks"
             mc:Ignorable="d" 
             d:DesignHeight="600" d:DesignWidth="800">
    
    <UserControl.Resources>
        <Thickness x:Key="ControlMargin">0 5 0 0</Thickness>
    </UserControl.Resources>

    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition />
            <ColumnDefinition />
            <ColumnDefinition />
            <ColumnDefinition />
            <ColumnDefinition />
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto" />
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>

        <StackPanel Grid.Column="0">
            <Label Content="Default Button" Style="{DynamicResource DescriptionHeaderStyle}" />
            <Button Width="100"
                    Margin="{StaticResource ControlMargin}"
                    Content="Enabled" />
            <Label Content="Square Button" Style="{DynamicResource DescriptionHeaderStyle}" />
            <Button Width="110"
                    Margin="{StaticResource ControlMargin}"
                    Content="Enabled"
                    Style="{DynamicResource MahApps.Styles.Button.Square}" />
            <Button Width="110"
                    Margin="{StaticResource ControlMargin}"
                    Content="Enabled"
                    Style="{DynamicResource MahApps.Styles.Button.Square.Accent}" />
            <Button Width="110"
                    Margin="{StaticResource ControlMargin}"
                    Content="Enabled"
                    Style="{DynamicResource MahApps.Styles.Button.Square.Highlight}" />
            <Button Width="110"
                    Margin="{StaticResource ControlMargin}"
                    Content="Disabled"
                    IsEnabled="False"
                    Style="{DynamicResource MahApps.Styles.Button.Square.Highlight}" />
        </StackPanel>



        <StackPanel Grid.Row="1"
                    HorizontalAlignment="Center"
                    UseLayoutRounding="True">
            <Label Content="ToggleSwitch" Style="{DynamicResource DescriptionHeaderStyle}" />

            <mah:ToggleSwitch Margin="{StaticResource ControlMargin}"
                              Header="Header"
                              IsOn="{Binding CanUseToggleSwitch, Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}" />
            <mah:ToggleSwitch Margin="{StaticResource ControlMargin}"
                              CommandParameter="{Binding}"
                              OffCommand="{Binding ToggleSwitchOffCommand}"
                              OnCommand="{Binding ToggleSwitchOnCommand}" />
            <mah:ToggleSwitch Margin="{StaticResource ControlMargin}"
                              Command="{Binding ToggleSwitchCommand}"
                              IsOn="True"
                              OffContent="Disabled"
                              OnContent="Enabled" />
            <mah:ToggleSwitch Margin="{StaticResource ControlMargin}"
                              IsEnabled="False"
                              IsOn="True"
                              OffContent="Disabled"
                              OnContent="Enabled" />
        </StackPanel>
        
        <StackPanel Grid.Row="0"
                    Grid.Column="1"
                    HorizontalAlignment="Center"
                    UseLayoutRounding="True">
            <StackPanel>
                <StackPanel.Resources>
                    <Style BasedOn="{StaticResource MahApps.Styles.CheckBox.Win10}" TargetType="{x:Type CheckBox}">
                        <Setter Property="ContentTemplate">
                            <Setter.Value>
                                <DataTemplate>
                                    <TextBlock Text="{Binding RelativeSource={RelativeSource AncestorType={x:Type CheckBox}}, Path=IsChecked, TargetNullValue='IsChecked = Null', Mode=OneWay, StringFormat='{}IsChecked = {0}'}" />
                                </DataTemplate>
                            </Setter.Value>
                        </Setter>
                        <Setter Property="Margin" Value="{StaticResource ControlMargin}" />
                    </Style>
                </StackPanel.Resources>

                <Label Content="CheckBox Win10" Style="{DynamicResource DescriptionHeaderStyle}" />
                <CheckBox mah:CheckBoxHelper.CheckCornerRadius="2"
                          IsChecked="False"
                          IsEnabled="True" />
                <CheckBox IsChecked="False" IsEnabled="False" />
                <CheckBox IsChecked="True" IsEnabled="False" />
                <CheckBox IsChecked="True" IsEnabled="True" />
                <CheckBox IsChecked="{x:Null}" IsEnabled="True" />
                <CheckBox IsChecked="{x:Null}" IsEnabled="False" />
            </StackPanel>

            <StackPanel>
                <StackPanel.Resources>
                    <Style BasedOn="{StaticResource MahApps.Styles.CheckBox}" TargetType="{x:Type CheckBox}">
                        <Setter Property="ContentTemplate">
                            <Setter.Value>
                                <DataTemplate>
                                    <TextBlock Text="{Binding RelativeSource={RelativeSource AncestorType={x:Type CheckBox}}, Path=IsChecked, TargetNullValue='IsChecked = Null', Mode=OneWay, StringFormat='{}IsChecked = {0}'}" />
                                </DataTemplate>
                            </Setter.Value>
                        </Setter>
                        <Setter Property="Margin" Value="{StaticResource ControlMargin}" />
                    </Style>
                </StackPanel.Resources>

                <Label Content="CheckBox" Style="{DynamicResource DescriptionHeaderStyle}" />
                <CheckBox IsChecked="False" IsEnabled="True" />
                <CheckBox IsChecked="False" IsEnabled="False" />
                <CheckBox IsChecked="True" IsEnabled="False" />
                <CheckBox IsChecked="True" IsEnabled="True" />
                <CheckBox IsChecked="{x:Null}" IsEnabled="True" />
                <CheckBox IsChecked="{x:Null}" IsEnabled="False" />
            </StackPanel>
        </StackPanel>


        <GroupBox Grid.Row="0"
                  Grid.Column="2"
                  Margin="4 2"
                  Header="TextBox"
                  UseLayoutRounding="True">
            <AdornerDecorator>
                <StackPanel>
                    <mah:MetroHeader Margin="{StaticResource ControlMargin}" Header="TextBox Header">
                        <mah:MetroHeader.HeaderTemplate>
                            <DataTemplate>
                                <StackPanel VerticalAlignment="Center" Orientation="Horizontal">
                                    <iconPacks:PackIconMaterial VerticalAlignment="Center" Kind="TextBox" />
                                    <TextBlock Margin="2 0 0 0"
                                               VerticalAlignment="Center"
                                               Text="{Binding}" />
                                </StackPanel>
                            </DataTemplate>
                        </mah:MetroHeader.HeaderTemplate>
                        <TextBox SpellCheck.IsEnabled="True" Text="Enabled">
                            <TextBox.ContextMenu>
                                <ContextMenu>
                                    <MenuItem Header="This is only a Test-Item" />
                                </ContextMenu>
                            </TextBox.ContextMenu>
                        </TextBox>
                    </mah:MetroHeader>
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ButtonCommand="{Binding ControlButtonCommand, Mode=OneWay}"
                             mah:TextBoxHelper.UseFloatingWatermark="True"
                             mah:TextBoxHelper.Watermark="Search...">
                        <TextBox.InputBindings>
                            <KeyBinding Key="Return"
                                        Command="{Binding ControlButtonCommand, Mode=OneWay}"
                                        CommandParameter="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType=TextBox}, Path=Text, Mode=OneWay}" />
                        </TextBox.InputBindings>
                        <TextBox.Style>
                            <Style BasedOn="{StaticResource MahApps.Styles.TextBox.Search}" TargetType="{x:Type TextBox}">
                                <Style.Triggers>
                                    <Trigger Property="mah:TextBoxHelper.HasText" Value="True">
                                        <Setter Property="mah:TextBoxHelper.ButtonContent" Value="r" />
                                        <Setter Property="mah:TextBoxHelper.ButtonContentTemplate" Value="{x:Null}" />
                                        <Setter Property="mah:TextBoxHelper.ClearTextButton" Value="True" />
                                    </Trigger>
                                </Style.Triggers>
                            </Style>
                        </TextBox.Style>
                    </TextBox>
                    <!--<TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ButtonCommand="{Binding ControlButtonCommandWithParameter, Mode=OneWay}"
                             mah:TextBoxHelper.ButtonContent="M17.545,15.467l-3.779-3.779c0.57-0.935,0.898-2.035,0.898-3.21c0-3.417-2.961-6.377-6.378-6.377  C4.869,2.1,2.1,4.87,2.1,8.287c0,3.416,2.961,6.377,6.377,6.377c1.137,0,2.2-0.309,3.115-0.844l3.799,3.801  c0.372,0.371,0.975,0.371,1.346,0l0.943-0.943C18.051,16.307,17.916,15.838,17.545,15.467z M4.004,8.287  c0-2.366,1.917-4.283,4.282-4.283c2.366,0,4.474,2.107,4.474,4.474c0,2.365-1.918,4.283-4.283,4.283  C6.111,12.76,4.004,10.652,4.004,8.287z"
                             mah:TextBoxHelper.Watermark="Search something..."
                             Style="{DynamicResource MahApps.Styles.TextBox.Search}" />
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ButtonContent="M17.545,15.467l-3.779-3.779c0.57-0.935,0.898-2.035,0.898-3.21c0-3.417-2.961-6.377-6.378-6.377  C4.869,2.1,2.1,4.87,2.1,8.287c0,3.416,2.961,6.377,6.377,6.377c1.137,0,2.2-0.309,3.115-0.844l3.799,3.801  c0.372,0.371,0.975,0.371,1.346,0l0.943-0.943C18.051,16.307,17.916,15.838,17.545,15.467z M4.004,8.287  c0-2.366,1.917-4.283,4.282-4.283c2.366,0,4.474,2.107,4.474,4.474c0,2.365-1.918,4.283-4.283,4.283  C6.111,12.76,4.004,10.652,4.004,8.287z"
                             mah:TextBoxHelper.Watermark="Find something..."
                             Style="{DynamicResource MahApps.Styles.TextBox.Search}">
                        <TextBox.CommandBindings>
                            --><!--<CommandBinding  Command="{x:Static mah:MahAppsCommands.SearchCommand}" />--><!--
                        </TextBox.CommandBindings>
                    </TextBox>-->
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ButtonCommand="{Binding ControlButtonCommand, Mode=OneWay}"
                             mah:TextBoxHelper.ButtonContent="s"
                             mah:TextBoxHelper.Watermark="Custom icon style" />
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.Watermark="Watermark"
                             IsEnabled="False" />
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ClearTextButton="True"
                             mah:TextBoxHelper.Watermark="Watermark"
                             IsEnabled="False"
                             Text="Clear button" />
                    <TextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.Watermark="Search style..."
                             IsEnabled="False"
                             Style="{DynamicResource MahApps.Styles.TextBox.Search}" />
                </StackPanel>
            </AdornerDecorator>
        </GroupBox>

        <ScrollViewer Grid.Row="0"
                      Grid.Column="3"
                      Grid.IsSharedSizeScope="True"
                      VerticalScrollBarVisibility="Auto">
            <StackPanel>
                <GroupBox Header="Text">
                    <StackPanel>
                        <mah:MetroHeader Header="Text">
                            <TextBox Text="{Binding ElementName=mscb_Example, Path=Text}" />
                        </mah:MetroHeader>
                        <mah:MetroHeader Header="IsReadOnly">
                            <mah:ToggleSwitch IsOn="{Binding ElementName=mscb_Example, Path=IsReadOnly}" />
                        </mah:MetroHeader>
                        <mah:MetroHeader Header="ItemStringFormat">
                            <TextBox Text="{Binding ElementName=mscb_Example, Path=ItemStringFormat, Mode=TwoWay}" />
                        </mah:MetroHeader>
                    </StackPanel>
                </GroupBox>
            </StackPanel>

        </ScrollViewer>

        <GroupBox Grid.Row="0"
                  Grid.Column="4"
                  Margin="4 2"
                  Header="RichTextBox"
                  UseLayoutRounding="True">
            <StackPanel>
                <RichTextBox Margin="{StaticResource ControlMargin}" ScrollViewer.HorizontalScrollBarVisibility="Auto">
                    <FlowDocument PageWidth="NaN">
                        <Paragraph>Hello</Paragraph>
                    </FlowDocument>
                </RichTextBox>
                <RichTextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ClearTextButton="True"
                             mah:TextBoxHelper.Watermark="Type something in..."
                             IsDocumentEnabled="True"
                             SpellCheck.IsEnabled="True" />
                <RichTextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ClearTextButton="True"
                             mah:TextBoxHelper.UseFloatingWatermark="True"
                             mah:TextBoxHelper.Watermark="Need some input..."
                             IsDocumentEnabled="True"
                             SpellCheck.IsEnabled="True" />
                <RichTextBox Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.ButtonCommand="{Binding ControlButtonCommand, Mode=OneWay}"
                             mah:TextBoxHelper.ButtonContent="s"
                             mah:TextBoxHelper.Watermark="Type in..."
                             IsDocumentEnabled="True"
                             SpellCheck.IsEnabled="True" />
                <RichTextBox Height="120"
                             Margin="{StaticResource ControlMargin}"
                             mah:TextBoxHelper.SelectAllOnFocus="True"
                             IsDocumentEnabled="True"
                             SpellCheck.IsEnabled="True">
                    <FlowDocument>
                        <Paragraph>
                            <Hyperlink NavigateUri="https://github.com/MahApps/MahApps.Metro">
                                <Run Text="Normal" />
                            </Hyperlink>
                            <LineBreak />
                            <Run>Cupcake ipsum dolor sit amet dessert halvah dessert. Chocolate oat cake carrot cake sweet dragée gummi bears chocolate.</Run>
                        </Paragraph>
                    </FlowDocument>
                </RichTextBox>
                <RichTextBox Height="120"
                             Margin="{StaticResource ControlMargin}"
                             IsDocumentEnabled="True"
                             IsReadOnly="True">
                    <FlowDocument>
                        <Paragraph>
                            <Hyperlink NavigateUri="https://github.com/MahApps/MahApps.Metro">
                                <Run Text="ReadOnly" />
                            </Hyperlink>
                            <LineBreak />
                            <Run>Cupcake ipsum dolor sit amet dessert halvah dessert. Chocolate oat cake carrot cake sweet dragée gummi bears chocolate.</Run>
                        </Paragraph>
                    </FlowDocument>
                </RichTextBox>
                <RichTextBox Height="120"
                             Margin="{StaticResource ControlMargin}"
                             IsDocumentEnabled="True"
                             IsEnabled="False">
                    <FlowDocument>
                        <Paragraph>
                            <Hyperlink NavigateUri="https://github.com/MahApps/MahApps.Metro">
                                <Run Text="Disabled" />
                            </Hyperlink>
                            <LineBreak />
                            <Run>Cupcake ipsum dolor sit amet dessert halvah dessert. Chocolate oat cake carrot cake sweet dragée gummi bears chocolate.</Run>
                        </Paragraph>
                    </FlowDocument>
                </RichTextBox>
            </StackPanel>
        </GroupBox>


    </Grid>
</UserControl>

```

## 5 MainWindowViewModel.cs

```C#
using ControlzEx.Theming;
using Prism.Commands;
using Prism.Mvvm;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;

namespace PlayWithMahApps.MetroForWork.ViewModels
{
    public class MainWindowViewModel : BindableBase
    {
        private string _title = "Prism Application";
        public string Title
        {
            get { return _title; }
            set { SetProperty(ref _title, value); }
        }

        public List<AppThemeMenuData> AppThemes { get; set; }

        public List<AccentColorMenuData> AccentColors { get; set; }

        public MainWindowViewModel()
        {
            // create metro theme color menu items for the demo
            this.AppThemes = ThemeManager.Current.Themes
                                         .GroupBy(x => x.BaseColorScheme)
                                         .Select(x => x.First())
                                         .Select(a => new AppThemeMenuData { Name = a.BaseColorScheme, BorderColorBrush = a.Resources["MahApps.Brushes.ThemeForeground"] as Brush, ColorBrush = a.Resources["MahApps.Brushes.ThemeBackground"] as Brush })
                                         .ToList();

            // create accent color menu items for the demo
            this.AccentColors = ThemeManager.Current.Themes
                                            .GroupBy(x => x.ColorScheme)
                                            .OrderBy(a => a.Key)
                                            .Select(a => new AccentColorMenuData { Name = a.Key, ColorBrush = a.First().ShowcaseBrush })
                                            .ToList();
        }
    }

    public class AppThemeMenuData : AccentColorMenuData
    {
        protected override void DoChangeTheme(string? name)
        {
            if (name is not null)
            {
                ThemeManager.Current.ChangeThemeBaseColor(Application.Current, name);
            }
        }
    }

    public class AccentColorMenuData
    {
        public string? Name { get; set; }

        public Brush? BorderColorBrush { get; set; }

        public Brush? ColorBrush { get; set; }

        public AccentColorMenuData()
        {
            //Update SimpleCommand with DelegateCommand 
            // this.ChangeAccentCommand = new SimpleCommand<string?>(o => true, this.DoChangeTheme);
            this.ChangeAccentCommand = new DelegateCommand<string>(ExecuteChangeACommand, CanExecuteChangeACommand);
        }

        void ExecuteChangeACommand(string name)
        {
            this.DoChangeTheme(name);
        }

        bool CanExecuteChangeACommand(string name)
        {
            return true;
        }


        public ICommand ChangeAccentCommand { get; }

        protected virtual void DoChangeTheme(string? name)
        {
            if (name is not null)
            {
                ThemeManager.Current.ChangeThemeColorScheme(Application.Current, name);
            }
        }
    }
}
```

