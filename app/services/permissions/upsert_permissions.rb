# frozen_string_literal: true

module Permissions
  class UpsertPermissions
    CREATE = 'create'
    READ = 'read'
    UPDATE = 'update'
    DELETE = 'delete'

    ACTION_PREFIX_MAP = {
      CREATE => 'cr', # *
      READ => 'rd',   # @
      UPDATE => 'ud', # !
      DELETE => 'dt'  # <
    }.freeze

    CRUD = [CREATE, READ, UPDATE, DELETE].freeze

    PERMISSIONS_CONFIG = {
      network: {
        postfix: 'nt',
        actions: CRUD
      },
      restaurant: {
        postfix: 'rs',
        actions: CRUD
      },
      meal: {
        postfix: 'me',
        actions: CRUD
      },
      table_session: {
        postfix: 'ts',
        actions: CRUD
      },
      order: {
        postfix: 'or',
        actions: CRUD
      }
    }.freeze

    def call
      validate!

      permissions_attributes.each do |attrs|
        permission = Permission.find_or_initialize_by(code: attrs[:code])
        permission.update!(attrs)
      end
    end

    private

    def permissions_attributes
      @permissions_attributes ||= PERMISSIONS_CONFIG.flat_map do |entity, config|
        config[:actions].map do |action|
          {
            code: "#{action}_#{entity}",
            name: code.split('_').map(&:capitalize).join(' '),
            token_code: "#{ACTION_PREFIX_MAP[action]}#{postfix}"
          }
        end
      end
    end

    def validate!
      return if postfix_duplicates.blank?

      raise "Permission Postfix duplicates found: #{postfix_duplicates}"
    end

    def postfix_duplicates
      @postfix_duplicates ||= begin
        postfixes = PERMISSIONS_CONFIG.values.pluck(:postfix)
        result = {}.tap do |mapping|
          postfixes.each do |postfix|
            mapping[postfix] ||= 0
            mapping[postfix] += 1
          end
        end

        result.select { |_postfix, appearance_count| appearance_count > 1 }
      end
    end
  end
end
