class Program
{ 
    static void Main(string[] args)
    {
        // 1 - добавить
        // 2 - изменить
        // 3 - удалить

        Customer customer = new Customer();
        customer.SetCommand(1);
        customer.SetMenuItem(new MenuItem("Latte", "Big"));
        customer.ExecuteCommand();

        customer.SetCommand(1);
        customer.SetMenuItem(new MenuItem("Mocka", "Small"));
        customer.ExecuteCommand();

        customer.SetCommand(1);
        customer.SetMenuItem(new MenuItem("Tea", "Big"));
        customer.ExecuteCommand();

        customer.ShowCurrentOrder();

        //убрали мока
        customer.SetCommand(3);
        customer.SetMenuItem(new MenuItem("Mocka", "Small"));
        customer.ExecuteCommand();

        customer.ShowCurrentOrder();

        //изменили размер латте
        customer.SetCommand(2);
        customer.SetMenuItem(new MenuItem("Latte", "Small"));
        customer.ExecuteCommand();

        customer.ShowCurrentOrder();

        Console.ReadKey();
    }
}


public class Customer
{
    OrderCommand orderCommand;
    MenuItem menuItem;
    Coffee coffee;

    public Customer()
    {
        coffee = new Coffee();
    }

    public void SetCommand(int commandOption)
    {
        orderCommand = new CommandFactory().GetCommand(commandOption);
    }

    public void SetMenuItem(MenuItem item)
    {
        menuItem = item;
    }

    public void ExecuteCommand()
    {
       coffee.ExecuteCommand(orderCommand,menuItem);
    }

    public void ShowCurrentOrder()
    {
       coffee.ShowCurrentItems();
    }
}

public class Coffee
{
    public List<MenuItem> currentItems { get; set; }
    public Coffee()
    {
        currentItems = new List<MenuItem>();
    }

    public void ExecuteCommand(OrderCommand command, MenuItem item)
    {
        command.Execute(this.currentItems, item);
    }

    public void ShowCurrentItems()
    {
        int sum = 0;
        foreach (var item in currentItems)
        {
            item.Display();
            sum += item.Price;
        }
        Console.WriteLine("\nTotal cost: " + sum);
        Console.WriteLine("-----------------------");
    }

}


public class MenuItem
{
    public string Name { get; set; }
    public string Size { get; set; }
    public int Price { get; set; }


    public MenuItem(string name, string size)
    {
        Name = name;
        Size = size;
    }

    public void Display()
    {
        Console.WriteLine("\nName: " + Name);
        Console.WriteLine("Size: " + Size);
        switch (Size)
        {
            case "Big":
                Console.WriteLine("Price: 270");
                Price = 270;
                break;
            case "Medium":
                Console.WriteLine("Price: 240");
                Price = 240;
                break;
            case "Small":
                Console.WriteLine("Price: 180");
                Price = 180;
                break;
        }
    }
}


public abstract class OrderCommand
{
    public abstract void Execute(List<MenuItem> order, MenuItem newItem);
}


public class AddCommand : OrderCommand
{
    public override void Execute(List<MenuItem> currentItems, MenuItem newItem)
    {
        currentItems.Add(newItem);
    }
}


public class RemoveCommand : OrderCommand
{
    public override void Execute(List<MenuItem> currentItems, MenuItem newItem)
    {
        currentItems.Remove(currentItems.Where(x => x.Name == newItem.Name).First());
    }
}


public class ModifyCommand : OrderCommand
{
    public override void Execute(List<MenuItem> currentItems, MenuItem newItem)
    {
        var item = currentItems.Where(x => x.Name == newItem.Name).First();
        item.Size = newItem.Size;
    }
}

public class CommandFactory
{
    //Factory method
    public OrderCommand GetCommand(int commandOption)
    {
        return commandOption switch
        {
            1 => new AddCommand(),
            2 => new ModifyCommand(),
            3 => new RemoveCommand(),
            _ => new AddCommand(),
        };
    }
}
