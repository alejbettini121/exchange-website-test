module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Document
      can :manage, Member
      can :manage, Ticket
      can :manage, IdDocument
      can :manage, TwoFactor

      can :menu, Deposit
      can :manage, ::Deposits::Bank
      can :manage, ::Deposits::Dollar
      can :manage, ::Deposits::Pound
      can :manage, ::Deposits::Satoshi
      can :manage, ::Deposits::Ether
      can :manage, ::Deposits::Bitcoincash
      can :manage, ::Deposits::Bitcoingold
      can :manage, ::Deposits::Ripple
      can :manage, ::Deposits::Litecoin

      can :menu, Withdraw
      can :manage, ::Withdraws::Bank
      can :manage, ::Withdraws::Dollar
      can :manage, ::Withdraws::Pound
      can :manage, ::Withdraws::Satoshi
      can :manage, ::Withdraws::Ether
      can :manage, ::Withdraws::Bitcoincash
      can :manage, ::Withdraws::Bitcoingold
      can :manage, ::Withdraws::Ripple
      can :manage, ::Withdraws::Litecoin

    end
  end
end
