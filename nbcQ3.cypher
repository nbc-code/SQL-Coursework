// Create db
// remove all nodes and edges
match (n) optional match (n)-[r]-()
delete n, r;

// remove the parts label
match(n:parts)
remove n:parts;

// remove the suppliers label
match (n:suppliers)
remove n:suppliers;

// remove the projects label
match (n:projects)
remove n:projects;

// drop pre-existing constraints
drop constraint pid_notnull if exists;
drop constraint pid_unique if exists;

drop constraint sid_notnull if exists;
drop constraint sid_unique if exists;

drop constraint jid_notnull if exists;
drop constraint jid_unique if exists;

// create constraints to ensure that pid is unique
create constraint pid_unique for (p:parts) require p.pid is unique;
create constraint pid_notnull for (p:parts) require p.pid is not null;

// Create one node per line; the node has the label parts
load csv with headers from 'file:///parts.csv' as line fieldterminator ';'
create (:parts {pid:toInteger(line.pid), pname: line.pname});

// create constraints to ensure that sid is unique
create constraint sid_unique for (s:suppliers) require s.sid is unique;
create constraint sid_notnull for (s:suppliers) require s.sid is not null;

// Create one node per line; the node has the label suppliers
load csv with headers from 'file:///suppliers.csv' as line fieldterminator ';'
create (:suppliers {sid:toInteger(line.sid), sname: line.sname});

// create constraints to ensure that jid is unique
create constraint jid_unique for (j:projects) require j.jid is unique;
create constraint jid_notnull for (j:projects) require j.jid is not null;

// Create one node per line; the node has the label projects
load csv with headers from 'file:///projects.csv' as line fieldterminator ';'
create (:projects {jid:toInteger(line.jid), jname: line.jname});

// Create one edge per line; the edge labeled SPJ from node with
// the supplier id to the node with the part id and to the node with
// the project id and the quantity from the csv file
load csv with headers from "file:///spj.csv" as line fieldterminator ';'
merge (s:suppliers {sid: toInteger(line.sid)})
merge (p:parts {pid: toInteger(line.pid)})
merge (j:projects {jid: toInteger(line.jid)})
create (s)-[:supplies]->(p)-[:suppliesparts{qty:toInteger(line.qty)}]->(j);