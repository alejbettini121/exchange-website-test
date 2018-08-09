require 'spec_helper'

describe "Articles" do
  let(:valid_params) { { :article => { :title => 'Doh', :content => Faker::Lorem.sentence } } }

  context "versioning disabled" do
    specify { PaperTrail.should_not be_enabled }

    it "should not create a version" do
      PaperTrail.should be_enabled_for_controller
      expect { post articles_path(valid_params) }.to_not change(PaperTrail::Version, :count)
      PaperTrail.should_not be_enabled_for_controller
    end

    it "should not leak the state of the `PaperTrail.enabled_for_controller?` into the next test" do
      PaperTrail.should be_enabled_for_controller
    end
  end

  with_versioning do
    let(:article) { Article.last }

    context "`current_user` method returns a `String`" do
      if RUBY_VERSION.to_f >= 1.9
        it "should set that value as the `whodunnit`" do
          expect { post articles_path(valid_params) }.to change(PaperTrail::Version, :count).by(1)
          article.title.should == 'Doh'
          PaperTrail.whodunnit.should == 'foobar'
          article.versions.last.whodunnit.should == 'foobar'
        end
      end
    end
  end
end
