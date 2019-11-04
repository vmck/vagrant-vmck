# Vagrant Vmck Provider

[Vagrant][] provider form [Vmck][].

[Vagrant]: https://www.vagrantup.com
[Vmck]: https://github.com/mgax/vmck


## Installation

1. [Install Vagrant](https://www.vagrantup.com/docs/installation/)
2. Install the plugin:
    ```shell
    $ vagrant plugin install vagrant-vmck
    ```

## Usage

See `examples/box/Vagrantfile` for an example configuration.

```shell
$ vagrant up --provider=vmck
```

The vmck provider is also packaged as a docker image:

```shell
./examples/docker.sh --dev --env VMCK_URL=http://10.66.60.1:9995
```


## Release

1. Update `lib/vagrant-vmck/version.rb` and commit
2. `git tag v1.2.3; git push --tags`

The [gempush workflow](.github/workflows/gempush.yml) takes care of the rest,
see it work away in the [actions
tab](https://github.com/vmck/vagrant-vmck/actions).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
