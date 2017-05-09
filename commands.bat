:: It's necessary to be in C: to install the Spreadsheet modules
cd \Strawberry
:: This will install cpanminus, which makes it easy to install the Spreadsheet module
cpan App::cpanminus
:: Use cpanminus to install Spreadsheet::Read and dependencies
cpanm --force Spreadsheet::ParseExcel Spreadsheet::XLSX Spreadsheet::Read >> install_log.txt
PAUSE