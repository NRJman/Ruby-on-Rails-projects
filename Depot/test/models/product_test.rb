require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products


  #   product properties must not be empty
  test " product properties must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:img_url].any?
  	assert product.errors[:price].any?
  end


  test " product price must be positive" do
  	product = Product.new(  title: "Something",
  							description: "Something about something",
  							img_url: "smth.jpeg")
  	product.price = -1
  	assert product.invalid?
  	assert_equal(["must be greater than or equal to 0.01"], product.errors[:price])

  	product.price = 0
  	assert product.invalid?
  	assert_equal(["must be greater than or equal to 0.01"], product.errors[:price])

  	product.price = 1
  	assert product.valid?
  end

  def new_product(img_url)
  	product = Product.new(  title: "Something",
  							description: "Something about something",
  							price: 1,
  							img_url: img_url)
  end


  test " img url must be correct" do
  	good = %w{ smt.jpg ever.gif ELSE.png www/http.astanavites.jpeg}
  	bad = %w{ document.doc hi-hi.what anything.else asd.jpeg.qws ewoif.gifaaa}

  	good.each do |name|
  		assert new_product(name).valid?, "#{name} must not be invalid"
  	end

  	bad.each do |name|
  		assert new_product(name).invalid?, "#{name} must be valid"
  	end
  end


  test " title must be unique" do
  	product = Product.new(  title: products(:electronics).title,
  							description: "Something about something",
  							price: 1,
  							img_url: "img_url.jpg")

  	assert product.invalid?
  	assert_equal(["the title must be unique"], product.errors[:title])
  end

end
