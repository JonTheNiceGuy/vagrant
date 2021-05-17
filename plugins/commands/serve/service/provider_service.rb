require 'vagrant/machine'
require 'vagrant/batch_action'
require 'vagrant/ui'

module VagrantPlugins
  module CommandServe
    module Service
      class ProviderService < SDK::ProviderService::Service
        prepend Util::HasBroker
        prepend Util::ExceptionLogger

        def usable(req, _unused_call)
          nil
        end

        def usable_spec(req, _unused_call)
          nil
        end

        def installed(req, _unused_call)
          nil
        end

        def installed_spec(req, _unused_call)
          nil
        end

        def init(req, _unused_call)
          nil
        end

        def init_spec(req, _unused_call)
          nil
        end

        def action_up(req, ctx)
          ServiceInfo.with_info(ctx) do |info|
            plugin_name = info.plugin_name
            raw_terminal = req.args.detect { |a|
              a.type == "hashicorp.vagrant.sdk.Args.TerminalUI"
            }&.value&.value
            raw_machine = req.args.detect { |a|
              a.type == "hashicorp.vagrant.sdk.Args.Machine"
            }&.value&.value
            ui = Client::Terminal.load(raw_terminal, broker: broker)
            machine = Client::Machine.load(raw_machine, ui)
            machine.ui.warn("hello from vagrant")
            SDK::Provider::ActionResp.new(success: true)
          end
        end

        def action_up_spec(req, _unused_call)
          args = [
            Hashicorp::Vagrant::Sdk::FuncSpec::Value.new(
              type: "hashicorp.vagrant.sdk.Args.TerminalUI",
              name: ""
            ),
            Hashicorp::Vagrant::Sdk::FuncSpec::Value.new(
              type: "hashicorp.vagrant.sdk.Args.Machine",
              name: ""
            ),
          ]
          result = [
            Hashicorp::Vagrant::Sdk::FuncSpec::Value.new(
              type: "hashicorp.vagrant.sdk.Provider.ActionResp",
              name: ""
            ),
          ]
          Hashicorp::Vagrant::Sdk::FuncSpec.new(
            args: args,
            result: result
          )
        end
      end
    end
  end
end
