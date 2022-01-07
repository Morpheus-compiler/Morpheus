"""This is a Cloudlab profile to run the test for the Morpheus ASPLOS'22 paper.

Instructions:
Wait for the profile instance to start, then `ssh` on the two nodes of the topology and follow the instructions specified in the [GitHub page](https://github.com/Morpheus-compiler/Morpheus).
"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg

# Create a portal context.
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()
 
# Add a raw PC to the request.
pktgen = request.RawPC("pktgen")
dut = request.RawPC("dut")

# Optional physical type for nodes.
pc.defineParameter("phystype",  "Optional physical node type",
                   portal.ParameterType.STRING, "c220g1",
                   longDescription="Specify a physical node type (c220g1,xl170,etc). " +
                   "Artifact tested on c220g1 (the default choice).")

# Retrieve the values the user specifies during instantiation.
params = pc.bindParameters()

# Request that a specific image be installed on this node
pktgen.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU20-64-STD";
dut.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU20-64-STD";

pktgen.hardware_type = params.phystype
dut.hardware_type = params.phystype

# Create a link between the two nodes
link1 = request.Link(members = [pktgen, dut])
link2 = request.Link(members = [pktgen, dut])

pktgen.addService(pg.Execute(shell="sh", command='/local/repository/update-grub-settings.sh'))
pktgen.addService(pg.Execute(shell="sh", command="sudo reboot"))

dut.addService(pg.Execute(shell="sh", command="/local/repository/upgrade-kernel.sh"))
dut.addService(pg.Execute(shell="sh", command='/local/repository/update-grub-settings.sh'))
dut.addService(pg.Execute(shell="sh", command="sudo reboot"))

portal.context.printRequestRSpec()