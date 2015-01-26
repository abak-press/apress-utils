# coding: utf-8

require File.expand_path('../../../../../../spec_helper', __FILE__)

describe Apress::Utils::Extensions::PostgreSQLAdapter do
  describe '#distinct' do
    let(:connection) { ActiveRecord::Base.connection }

    context 'when string orders' do
      it do
        expect(
          connection.distinct('posts.title', ['posts.updater_id desc nulls first'])
        ).to eq 'DISTINCT posts.title, posts.updater_id AS alias_0'
      end

      it do
        expect(
          connection.distinct('posts.title', ['posts.updater_id desc nulls last'])
        ).to eq 'DISTINCT posts.title, posts.updater_id AS alias_0'
      end
    end

    context 'when arel expression in orders clause' do
      before do
        class Post < ActiveRecord::Base
          self.table_name = 'posts'
        end
      end

      it do
        expect(
          connection.distinct('posts.title', [Post.arel_table[:updater_id].desc, 'posts.creater_id asc nulls first'])
        ).to eq 'DISTINCT posts.title, "posts"."updater_id" AS alias_0, posts.creater_id AS alias_1'
      end
    end
  end
end
