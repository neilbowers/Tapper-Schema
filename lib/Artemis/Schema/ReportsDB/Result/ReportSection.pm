package Artemis::Schema::ReportsDB::Result::ReportSection;

use strict;
use warnings;

use parent 'DBIx::Class';
use parent 'Artemis::Schema::Printable';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("reportsection");
__PACKAGE__->add_columns
    (
     "id",                      { data_type => "INT",      default_value => undef, is_nullable => 0, size => 11, is_auto_increment => 1, },
     "report_id",               { data_type => "INT",      default_value => undef, is_nullable => 0, size => 11, is_foreign_key => 1, },
     "succession",              { data_type => "INT",      default_value => undef, is_nullable => 1, size => 10,                      },
     "name",                    { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     # machine/os environment
     "osname",                  { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "uname",                   { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "flags",                   { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "changeset",               { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "description",             { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "language_description",    { data_type => "TEXT",     default_value => undef, is_nullable => 1, size => 255,                     },
     "cpuinfo",                 { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "bios",                    { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "ram",                     { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 50,                      },
     "uptime",                  { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 50,                      },
     "lspci",                   { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "lsusb",                   { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "flags",                   { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     # xen info
     "xen_changeset",           { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "xen_hvbits",              { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 10,                      },
     "xen_dom0_kernel",         { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "xen_base_os_description", { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "xen_guest_description",   { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "xen_guest_flags",         { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "xen_version",             { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "xen_guest_test",          { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "xen_guest_start",         { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     # kvm info
     "kvm_kernel",              { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "kvm_base_os_description", { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "kvm_guest_description",   { data_type => "TEXT",     default_value => undef, is_nullable => 1,                                  },
     "kvm_module_version",      { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "kvm_userspace_version",   { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "kvm_guest_flags",         { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "kvm_guest_test",          { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
     "kvm_guest_start",         { data_type => "VARCHAR",  default_value => undef, is_nullable => 1, size => 255,                     },
    );

__PACKAGE__->set_primary_key("id");

__PACKAGE__->has_many   ( report => 'Artemis::Schema::ReportsDB::Result::Report', { 'foreign.id' => 'self.report_id' });


# -------------------- methods on results --------------------

sub some_meta_available
{
        my ($self) = @_;
        my %cols = $self->get_columns;

        # this enumeration is a bit lame. anyway: copy the list from Artemis::TAP::Harness.@SECTION_HEADER_KEYS_GENERAL.
        my @meta_cols = qw/ram cpuinfo bios lspci uname osname uptime language-description
                           flags changeset description
                           xen-version xen-changeset xen-dom0-kernel xen-base-os-description
                           xen-guest-description xen-guest-test xen-guest-start xen-guest-flags
                           kvm-module-version kvm-userspace-version kvm-kernel
                           kvm-base-os-description kvm-guest-description
                           kvm-guest-test kvm-guest-start kvm-guest-flags
                           flags
                          /;
        return 1 if grep { defined } @cols{@meta_cols};
        return 0;
}


1;

=head1 NAME

Artemis::Schema::ReportsDB::ReportSection - A ResultSet description


=head1 SYNOPSIS

Abstraction for the database table.

 use Artemis::Schema::ReportsDB;


=head1 AUTHOR

OSRC SysInt Team, C<< <osrc-sysint at elbe.amd.com> >>


=head1 BUGS

None.


=head1 COPYRIGHT & LICENSE

Copyright 2008 OSRC SysInt Team, all rights reserved.

This program is released under the following license: restrictive

