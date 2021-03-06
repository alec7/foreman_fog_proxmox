# frozen_string_literal: true

# Copyright 2018 Tristan Robert

# This file is part of ForemanFogProxmox.

# ForemanFogProxmox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# ForemanFogProxmox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with ForemanFogProxmox. If not, see <http://www.gnu.org/licenses/>.

require 'fog/proxmox/helpers/cpu_helper'

module FogExtensions
    module Proxmox
        module ServerConfig
            extend ActiveSupport::Concern
            def cpu_type
                Fog::Proxmox::CpuHelper.extract_type(cpu)
            end
            def spectre
                Fog::Proxmox::CpuHelper.extract_spectre(cpu)
            end
            def pcid
                Fog::Proxmox::CpuHelper.extract_pcid(cpu)
            end
            def cdrom
                if disks.cdrom
                    %w[none cdrom].include?(disks.cdrom.volid) ? disks.cdrom.volid : 'image'
                else
                    'none'
                end
            end
            def cdrom_storage
                disks.cdrom ? disks.cdrom.storage : ''
            end
            def cdrom_iso
                disks.cdrom ? disks.cdrom.volid : ''
            end
            def cdrom_image
                if disks.cdrom
                    %w[none cdrom].include?(disks.cdrom.volid) ? disks.cdrom.volid : 'image'
                else
                    'none'
                end
            end
            def rootfs_storage
                disks.rootfs.storage if disks.rootfs
            end
            def rootfs_file
                disks.rootfs.volid if disks.rootfs
            end
        end
    end
end   