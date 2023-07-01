using System.Text;

class Program
{
    static void Main(string[] args)
    {
        Barista barista = new Barista();

        Coffeemaker cfm = new Coffeemaker1();
        Coffee coffee1 = barista.Make(cfm);
        Console.WriteLine(coffee1.ToString());
        cfm = new Coffeemaker2();
        Coffee coffee2 = barista.Make(cfm);
        Console.WriteLine(coffee2.ToString());

        Console.Read();
    }
}

abstract class Coffeemaker
{
    public Coffee coffee;
    public void MakeCoffee()
    {
        coffee = new Coffee();
    }
    public abstract void SetType();
    public abstract void AddMilk();
    public abstract void AddIce();
    public abstract void AddToppings();

}

class Barista
{
    public Coffee Make(Coffeemaker coffeemaker)
    {
        coffeemaker.MakeCoffee();
        coffeemaker.SetType();
        coffeemaker.AddMilk();
        coffeemaker.AddIce();
        coffeemaker.AddToppings();
        return coffeemaker.coffee;
    }
}

class Coffeemaker1 : Coffeemaker
{
    public override void SetType()
    {
        this.coffee.coffeetype = "latte";
    }

    public override void AddMilk()
    {
        this.coffee.milk = "almond milk";
    }

    public override void AddIce()
    {
        this.coffee.ice = "with ice";
    }

    public override void AddToppings()
    {

    }

}
class Coffeemaker2 : Coffeemaker
{
    public override void SetType()
    {
        this.coffee.coffeetype = "cappuccino";
    }

    public override void AddMilk()
    {
        this.coffee.milk = "regular milk";
    }

    public override void AddToppings()
    {
        this.coffee.toppings = "with raspberry syrop";
    }

    public override void AddIce()
    {

    }

}
class Coffee
{
    public string coffeetype;
    public string milk;
    public string ice;
    public string toppings;


    public override string ToString()
    {
        StringBuilder sb = new StringBuilder();

        sb.Append("Ordered coffee recipe:\n");
        sb.Append(this.coffeetype + "\n");
        if (milk != null)
            sb.Append(this.milk + "\n");
        if (ice != null)
            sb.Append(this.ice + "\n");
        if (toppings != null)
            sb.Append(this.toppings + "\n");
        return sb.ToString();
    }
}
