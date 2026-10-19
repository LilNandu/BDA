#!/usr/bin/env bash set -Eeuo pipefail

============================================================
BDA Experiment 1: Apache Hive installation and practical
Platform: Ubuntu Linux
Hadoop: 3.4.1
Hive: 4.2.1
Java: 21
Run:
chmod +x install_hive_practical.sh
./install_hive_practical.sh
Existing experiment1_hive_commands.hql is NEVER overwritten.
============================================================

HADOOP_VERSION="3.4.1" HIVE_VERSION="4.2.1" BASE_DIR="$HOME/bda-hive-lab" DOWNLOAD_DIR="$BASE_DIR/downloads" HADOOP_HOME="$BASE_DIR/hadoop" HIVE_HOME="$BASE_DIR/hive" PRACTICAL_FILE="$PWD/experiment1_hive_commands.hql"

export DEBIAN_FRONTEND=noninteractive

log() { echo echo "============================================================" echo "$1" echo "============================================================" }

fail() { echo "ERROR: $*" >&2 exit 1 }

trap 'echo "ERROR: Script failed near line $LINENO. Check the message above." >&2' ERR

[[ "$(uname -s)" == "Linux" ]] || fail "This script requires Linux." command -v apt-get >/dev/null 2>&1 || fail "This script requires Ubuntu/Debian with apt-get."

------------------------------------------------------------
STEP 1: Install operating-system dependencies
------------------------------------------------------------

log "STEP 1/9: Installing dependencies"

sudo apt-get update sudo apt-get install -y
openjdk-21-jdk
curl
wget
tar
gzip
procps
netcat-openbsd
python3
ca-certificates

JAVA_BIN="
(
𝑟
𝑒
𝑎
𝑑
𝑙
𝑖
𝑛
𝑘
−
𝑓
"
(command -v javac)")" JAVA_HOME="
(
𝑑
𝑖
𝑟
𝑛
𝑎
𝑚
𝑒
"
(dirname "$JAVA_BIN")")"

export JAVA_HOME export PATH="
𝐽
𝐴
𝑉
𝐴
𝐻
𝑂
𝑀
𝐸
/
𝑏
𝑖
𝑛
:
PATH"

java -version echo "JAVA_HOME=$JAVA_HOME"

------------------------------------------------------------
STEP 2: Create directories
------------------------------------------------------------

log "STEP 2/9: Preparing installation directories"

mkdir -p "
𝐷
𝑂
𝑊
𝑁
𝐿
𝑂
𝐴
𝐷
𝐷
𝐼
𝑅
"
"
BASE_DIR/tmp"

Do not replace an existing practical file.

if [[ -e "$PRACTICAL_FILE" ]]; then echo "Keeping existing practical unchanged: $PRACTICAL_FILE" else log "Creating the original Experiment 1 file"

cat > "$PRACTICAL_FILE" <<'HQL'


-- BDA Experiment 1: Basic Apache Hive commands on Ubuntu -- HOW TO RUN: -- 1. Make sure Hadoop and Hive are installed and configured. -- 2. From the terminal, run one of these commands: -- hive -f experiment1_hive_commands.hql -- OR, when HiveServer2 is running: -- beeline -u 'jdbc:hive2://localhost:10000/default' -f experiment1_hive_commands.hql -- 3. This script creates a database/table, shows and describes them, then drops the table. -- 4. It keeps the database after execution. To remove the database too, uncomment the final line.

-- CREATE: create a database if it does not already exist. CREATE DATABASE IF NOT EXISTS bda_practical;

-- SHOW: list all databases; bda_practical should appear in this list. SHOW DATABASES;

-- USE: make bda_practical the active database for following commands. USE bda_practical;

-- CREATE: create a simple student table. CREATE TABLE IF NOT EXISTS student ( student_id INT, student_name STRING, age INT ) COMMENT 'Sample table for BDA Hive practical' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- SHOW: list tables in the currently selected database; student should appear. SHOW TABLES;

-- DESCRIBE: show column names and data types for the student table. DESCRIBE student;

-- DESCRIBE FORMATTED: optional extra details about storage and table metadata. DESCRIBE FORMATTED student;

-- DROP: remove the student table if it exists. DROP TABLE IF EXISTS student;

-- SHOW again to verify that student has been removed. SHOW TABLES;

-- OPTIONAL CLEANUP: remove the database and its contents as well. -- Uncomment this line only if you want to delete bda_practical completely. -- DROP DATABASE IF EXISTS bda_practical CASCADE; HQL

echo "Created: $PRACTICAL_FILE"


fi

------------------------------------------------------------
STEP 3: Download and install Hadoop
------------------------------------------------------------

log "STEP 3/9: Installing Hadoop $HADOOP_VERSION"

HADOOP_ARCHIVE="
𝐷
𝑂
𝑊
𝑁
𝐿
𝑂
𝐴
𝐷
𝐷
𝐼
𝑅
/
ℎ
𝑎
𝑑
𝑜
𝑜
𝑝
−
HADOOP_VERSION.tar.gz" HADOOP_URL="https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"

if [[ ! -x "$HADOOP_HOME/bin/hadoop" ]]; then [[ -f "$HADOOP_ARCHIVE" ]] ||
wget -O "
𝐻
𝐴
𝐷
𝑂
𝑂
𝑃
𝐴
𝑅
𝐶
𝐻
𝐼
𝑉
𝐸
"
"
HADOOP_URL"

mkdir -p "$BASE_DIR/hadoop-extract"
tar -xzf "$HADOOP_ARCHIVE" \
    -C "$BASE_DIR/hadoop-extract"

rm -rf "$HADOOP_HOME"
mv "$BASE_DIR/hadoop-extract/hadoop-$HADOOP_VERSION" "$HADOOP_HOME"
rmdir "$BASE_DIR/hadoop-extract"


fi

export HADOOP_HOME export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop" export PATH="
𝐻
𝐴
𝐷
𝑂
𝑂
𝑃
𝐻
𝑂
𝑀
𝐸
/
𝑏
𝑖
𝑛
:
HADOOP_HOME/sbin:$PATH"

------------------------------------------------------------
STEP 4: Configure Hadoop for local filesystem operation
------------------------------------------------------------

log "STEP 4/9: Configuring Hadoop"

Hive can run this practical without an HDFS cluster.
Hadoop's local filesystem avoids SSH and NameNode formatting.

cat > "$HADOOP_CONF_DIR/hadoop-env.sh" <<EOF export JAVA_HOME="$JAVA_HOME" EOF

cat > "$HADOOP_CONF_DIR/core-site.xml" <<'XML'

<?xml version="1.0"?>

<configuration>
<property>
<name>fs.defaultFS</name>
<value>file:///</value>
</property>
<property>
<name>hadoop.tmp.dir</name>
<value>${user.home}/bda-hive-lab/tmp/hadoop</value>
</property>
</configuration>
XML

cat > "$HADOOP_CONF_DIR/mapred-site.xml" <<'XML'

<?xml version="1.0"?>

<configuration>
<property>
<name>mapreduce.framework.name</name>
<value>local</value>
</property>
</configuration>
XML

------------------------------------------------------------
STEP 5: Download and install Hive
------------------------------------------------------------

log "STEP 5/9: Installing Apache Hive $HIVE_VERSION"

HIVE_ARCHIVE="
𝐷
𝑂
𝑊
𝑁
𝐿
𝑂
𝐴
𝐷
𝐷
𝐼
𝑅
/
𝑎
𝑝
𝑎
𝑐
ℎ
𝑒
−
ℎ
𝑖
𝑣
𝑒
−
HIVE_VERSION-bin.tar.gz" HIVE_URL="https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz"

if [[ ! -x "$HIVE_HOME/bin/beeline" ]]; then [[ -f "$HIVE_ARCHIVE" ]] ||
wget -O "
𝐻
𝐼
𝑉
𝐸
𝐴
𝑅
𝐶
𝐻
𝐼
𝑉
𝐸
"
"
HIVE_URL"

mkdir -p "$BASE_DIR/hive-extract"
tar -xzf "$HIVE_ARCHIVE" \
    -C "$BASE_DIR/hive-extract"

rm -rf "$HIVE_HOME"
mv "$BASE_DIR/hive-extract/apache-hive-$HIVE_VERSION-bin" "$HIVE_HOME"
rmdir "$BASE_DIR/hive-extract"


fi

export HIVE_HOME export PATH="
𝐻
𝐼
𝑉
𝐸
𝐻
𝑂
𝑀
𝐸
/
𝑏
𝑖
𝑛
:
PATH"

Configure Hive to use a local Derby metastore and local warehouse.

mkdir -p "
𝐵
𝐴
𝑆
𝐸
𝐷
𝐼
𝑅
/
𝑚
𝑒
𝑡
𝑎
𝑠
𝑡
𝑜
𝑟
𝑒
"
"
BASE_DIR/warehouse"

cat > "$HIVE_HOME/conf/hive-site.xml" <<EOF

<?xml version="1.0"?>

<configuration>
<property>
<name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:derby:$BASE_DIR/metastore/metastore_db;create=true</value>
</property>
<property>
<name>javax.jdo.option.ConnectionDriverName</name>
<value>org.apache.derby.iapi.jdbc.AutoloadedDriver</value>
</property>
<property>
<name>hive.metastore.warehouse.dir</name>
<value>file://$BASE_DIR/warehouse</value>
</property>
<property>
<name>hive.execution.engine</name>
<value>mr</value>
</property>
<property>
<name>hive.server2.thrift.bind.host</name>
<value>127.0.0.1</value>
</property>
<property>
<name>hive.server2.thrift.port</name>
<value>10000</value>
</property>
<property>
<name>hive.server2.enable.doAs</name>
<value>false</value>
</property>
<property>
<name>hive.metastore.schema.verification</name>
<value>false</value>
</property>
<property>
<name>hive.server2.logging.operation.enabled</name>
<value>false</value>
</property>
</configuration>
EOF

------------------------------------------------------------
STEP 6: Initialize Hive's Derby metastore
------------------------------------------------------------

log "STEP 6/9: Initializing Hive metastore"

cd "$BASE_DIR"

Stop if an existing Derby database is already initialized.

if [[ ! -d "$BASE_DIR/metastore/metastore_db" ]]; then "$HIVE_HOME/bin/schematool" -dbType derby -initSchema else echo "Metastore directory already exists; checking its schema." if ! "$HIVE_HOME/bin/schematool" -dbType derby -info; then fail "Existing metastore schema is not usable. Back it up and inspect it before reinitializing." fi fi

------------------------------------------------------------
STEP 7: Start HiveServer2
------------------------------------------------------------

log "STEP 7/9: Starting HiveServer2"

if ! nc -z 127.0.0.1 10000 2>/dev/null; then nohup "$HIVE_HOME/bin/hiveserver2"
> "$BASE_DIR/hiveserver2.log" 2>&1 & echo 
!
>
"
BASE_DIR/hiveserver2.pid" fi

echo "Waiting for HiveServer2 on port 10000..." READY=0 for attempt in $(seq 1 60); do if nc -z 127.0.0.1 10000 2>/dev/null; then READY=1 break fi sleep 5 done

if [[ "$READY" -ne 1 ]]; then echo "HiveServer2 did not become ready. Recent log output:" tail -n 80 "$BASE_DIR/hiveserver2.log" || true fail "HiveServer2 startup failed." fi

------------------------------------------------------------
STEP 8: Run the supplied practical file
------------------------------------------------------------

log "STEP 8/9: Running Experiment 1 with Beeline"

echo "Practical file: $PRACTICAL_FILE" echo "Connecting to: jdbc:hive2://127.0.0.1:10000/default"

"$HIVE_HOME/bin/beeline"
-u 'jdbc:hive2://127.0.0.1:10000/default'
-n "$USER"
-f "$PRACTICAL_FILE"

------------------------------------------------------------
STEP 9: Report results and locations
------------------------------------------------------------

log "STEP 9/9: Installation and practical completed"

echo "Hive version:" "$HIVE_HOME/bin/hive" --version 2>&1 | head -n 5 || true

echo echo "Hadoop version:" "$HADOOP_HOME/bin/hadoop" version | head -n 2

echo echo "HiveServer2 log: $BASE_DIR/hiveserver2.log" echo "Hive home: $HIVE_HOME" echo "Hadoop home: $HADOOP_HOME" echo "Practical file: $PRACTICAL_FILE" echo echo "The practical should leave database bda_practical in place." echo "The student table should have been dropped by the HQL file." echo "To inspect the database again, run:" echo " $HIVE_HOME/bin/beeline -u jdbc:hive2://127.0.0.1:10000/default" echo echo "Installation script finished."
