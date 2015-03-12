//module gs;

//import gtk.Main;
//import gtk.MainWindow;
import std.stdio, std.system, std.conv, std.socket, std.path, std.math, std.numeric, std.algorithm;
import ax.multi.labels, ax.application.configurations, ax.console.ins, ax.console.outs;
import vibe.core.log;
import ddbc.drivers.mysqlddbc;
import hibernated.core;
import hibernated.dialects.mysqldialect;


/*
class GsGtkd : MainWindow
{
   this()
   {
      super("Getting Started with Gtkd");
      setSizeRequest(600, 400);
      move(200, 200);
      showAll();
   }
}
*/

@Entity
@Table("kernel_users")
class KernelUsers {
	int id;
	int id_kernel_levels;
	string login;
	string pass;
	string saher;
	ulong balance;
	ulong number_visits;
}

@Entity
@Table("addresses")
class Addresses {
	int id;
}

void main()
{
	auto cf = new Configurations("pname");
	immutable n = 8;
	Labels[n] l;
	foreach (uint i; 0..n)
	{
		l[i] = new Labels;
	}
	l[0].id(1);
	l[0].name(cf.appNameTrans);
	writeln(l[0].name);
	uint st,Count,ds2;
	version(USE_MYSQL)
	{
		writeln("MySQL start");
		MySQLDriver driver = new MySQLDriver();
		string url = MySQLDriver.generateUrl("localhost", 3306, "axdb");
		string[string] params = MySQLDriver.setUserAndPassword("root", "pass");
		DataSource ds = new ConnectionPoolDataSourceImpl(driver, url, params);
	}
    // create metadata from annotations
    EntityMetaData schema = new SchemaInfoImpl!(KernelUsers);

    // create session factory
	Dialect dialect = new MySQLDialect();
	SessionFactory factory = new SessionFactoryImpl(schema, dialect, ds);
	scope(exit) factory.close();

    // create session
    Session sess = factory.openSession();
    scope(exit) sess.close();
	Query q = sess.createQuery("FROM KernelUsers ORDER BY id");
	writefln( "query result: %s", q.listRows() );
    // use session to access DB

//    User[] list = q.list!User();

    // create sample data
    KernelUsers r10 = new KernelUsers();
    r10.login = "role10";
    r10.pass = "3d10";
    r10.saher = "3d10";
	r10.id_kernel_levels = 1;
	r10.balance = 546;
	
	import std.algorithm, std.range, std.stdio, std.bitmanip, std.bigint;
	    {
        double x = -4.003;
        auto y = *cast(DoubleRep*)(&x);
        writeln(y.fraction, ", ",
                y.exponent, ", ",
                y.sign);
        writefln("%b",y.fraction);
        writefln("%d",to!int(x));

    }

 //   sess.save(r10);
 //       Addresses r11 = new Addresses();
 //   r11.id = "role11";
 //   sess.save(r11);
/*    Customer c10 = new Customer();
    c10.name = "Customer 10";
    User u10 = new User();
    u10.name = "Alex";
    u10.roles = [r10, r11];
    
    sess.save(r11);
    sess.save(c10);
    sess.save(u10);

    // load and check data
    User u11 = sess.createQuery("FROM User WHERE name=:Name").setParameter("Name", "Alex").uniqueResult!User();
    assert(u11.roles.length == 2);
    assert(u11.roles[0].name == "role10" || u11.roles.get()[0].name == "role11");
    assert(u11.roles[1].name == "role10" || u11.roles.get()[1].name == "role11");
    assert(u11.roles[0].users.length == 1);
    assert(u11.roles[0].users[0] == u10);

    // remove reference
//    u11.roles.get().remove(0);
    sess.update(u11);

    // remove entity
    sess.remove(u11);
*/
/*	readf("%s %s", &st, &Count);
	
	while (readln())
	{
		//version(linux) system("clear");
		foreach (i; st..Count)
		{
			dchar m = cast(dchar) i;
			write(i, "\t");
			write(m, "\t");
		}
		st += 255;
		Count += 255;
	}*/
}
