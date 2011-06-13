use inc::Module::Install;

name 'timobileref';
all_from 'timobileref';
readme_from 'timobileref';

no_index directory => 'orig';

requires_external_bin 'w3m';
configure_requires 'Module::Install::ReadmeFromPod';
configure_requires 'File::Slurp';
requires 'File::ShareDir';

install_script 'timobileref';
mkdir 'doc';
do 'tools/tidy.pl';
install_share dist => 'doc';

auto_include;
# auto_install;

WriteAll;

