package simu5g.simulations.NR.cars;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.ethernet.Eth10G;

import simu5g.world.radio.LteChannelControl;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.PgwStandard;
import simu5g.common.binder.Binder;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.eNodeB;
import simu5g.nodes.cars.NRCar;

// Se ha eliminado "import simu5g.nodes.Upf;" porque ya no se usa

import org.car2x.veins.subprojects.veins_inet.VeinsInetManager;

network Highway
{
    parameters:
        double playgroundSizeX @unit(m);
        double playgroundSizeY @unit(m);
        double playgroundSizeZ @unit(m);
        @display("bgb=1750,1000");

    submodules:
        routingRecorder: RoutingTableRecorder { @display("p=50,75;is=s"); }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,125");
            config = xmldoc("demo.xml");
        }
        veinsManager: VeinsInetManager { @display("p=50,227;is=s"); }
        channelControl: LteChannelControl { @display("p=50,25;is=s"); }
        binder: Binder { @display("p=50,175;is=s"); }
        carrierAggregation: CarrierAggregation { @display("p=50,258;is=s"); }
        server: StandardHost { @display("p=709,136;is=n;i=device/server"); }
        router: Router { @display("p=596,135;i=device/smallrouter"); }
        pgw: PgwStandard { @display("p=462,135;is=l"); }

        // El módulo 'upf' ha sido eliminado

        gNodeB1: gNodeB { // Secondary Node (5G) - Ahora solo conectado vía X2
            @display("p=300,600;is=vl");
        }
        masterEnb: eNodeB { // Master Node (4G)
            @display("p=300,300;is=vl");
        }
        car[0]: NRCar;

    connections allowunconnected:
        // Conexiones al router
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;

        // Conexión de la estación base maestra a su gateway
        pgw.pppg++ <--> Eth10G <--> masterEnb.ppp;

        // La conexión del gNodeB al núcleo ha sido eliminada

        // Conexión X2 para Dual Connectivity sigue siendo esencial
        masterEnb.x2++ <--> Eth10G <--> gNodeB1.x2++;
}