# Source directory
SRC_DIR=/home/prouza/myproject

# Include DIR (e.g. to search for /copy members in RPG sources)
INC_DIR=/home/prouza/myproject

# Directory for compile logs
LOG_DIR=$(SRC_DIR)/logs
# Directory to create a dummy file for each object. (For source timestamp change check)
TGT_DIR=$(SRC_DIR)/build

# Test system
TGTLIB_PGM=PROUZALIB
TGTLIB_DBF=PROUZALIB