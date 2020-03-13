class TestsController < AssessmentsController
  load_and_authorize_resource

  def index
    @tests = Test.all.order(id: :desc)
  end

  def new
    question = @test.questions.build
    question.options.build
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to test_path(@test), notice: 'The test was created successfully.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @test.assign_attributes(test_params)

    if @test.save
      redirect_to test_path(@test), notice: 'The test was updated successfully.'
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @test.destroy!
    redirect_to tests_path, notice: 'The test was deleted successfully.'
  end

  private

  def test_params
    params.require(:test).permit(:name, :description,
      questions_attributes: [:id, :label, :description, :_destroy,
        options_attributes: [:id, :content, :correct, :_destroy]
      ]
    )
  end
end