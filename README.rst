=======
sublime
=======

Salt formula to install and configure sublime for users.

.. note::

    See the full `Salt Formulas installation and usage instructions
    http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html`_.

    See pillar.example, defaults.yaml for setup.


Available states
================

.. contents::
    :local:


``sublime``
---------

Installs sublime with package control plugin and default packages/preferences.
These are only installed if they do not already exist, to prevent customization
overwrites.
