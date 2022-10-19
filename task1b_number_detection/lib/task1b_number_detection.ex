defmodule Task1bNumberDetection do
  @moduledoc """
  A module that implements functions for detecting numbers present in a grid in provided image
  """
  alias Evision, as: OpenCV
  use Bitwise

  def show(%Evision.Mat{channels: _, dims: _, raw_type: _, ref: image1, shape: _, type: _}) do
    Evision.HighGui.imshow("image", image1)
    Evision.HighGui.waitKey(7000)
    Evision.HighGui.destroyWindow("image")
  end

  @doc """
  #Function name:
         identifyCellNumbers
  #Inputs:
         image  : Image path with name for which numbers are to be detected
  #Output:
         Matrix containing the numbers detected
  #Details:
         Function that takes single image as an argument and provides the matrix of detected numbers
  #Example call:

      iex(1)> Task1bNumberDetection.identifyCellNumbers("images/grid_1.png")
      [["22", "na", "na"], ["na", "na", "16"], ["na", "25", "na"]]
  """
  def identifyCellNumbers(image) do
    thrVal =
      OpenCV.imread(image, flags: OpenCV.cv_IMREAD_GRAYSCALE())
      |> OpenCV.adaptiveThreshold(255, 1, 1, 11, 2)
      |> OpenCV.findContours(OpenCV.cv_RETR_TREE(), OpenCV.cv_CHAIN_APPROX_NONE())
      |> elem(0)
      |> enum_at(0)
  end

  def enum_at([h | t] = x, i) when i > 0 do
    enum_at(t, i - 1)
  end

  def enum_at([h | t], i), do: h

  @doc """
  #Function name:
         identifyCellNumbersWithLocations
  #Inputs:
         matrix  : matrix containing the detected numbers
  #Output:
         List containing tuple of detected number and it's location in the grid
  #Details:
         Function that takes matrix generated as an argument and provides list of tuple
  #Example call:

        iex(1)> matrix = Task1bNumberDetection.identifyCellNumbers("images/grid_1.png")
        [["22", "na", "na"], ["na", "na", "16"], ["na", "25", "na"]]
        iex(2)> Task1bNumberDetection.identifyCellNumbersWithLocations(matrix)
        [{"22", 1}, {"16", 6}, {"25", 8}]
  """
  def identifyCellNumbersWithLocations(matrix) do
  end

  @doc """
  #Function name:
         driver
  #Inputs:
         path  : The path where all the provided images are present
  #Output:
         A final output with image name as well as the detected number and it's location in gird
  #Details:
         Driver functional which detects numbers from mutiple images provided
  #Note:
         DO NOT EDIT THIS FUNCTION
  #Example call:

      iex(1)> Task1bNumberDetection.driver("images/")
      [
        {"grid_1.png", [{"22", 1}, {"16", 6}, {"25", 8}]},
        {"grid_2.png", [{"13", 3}, {"21", 5}, {"20", 7}]},
        {"grid_3.png", [{"17", 3}, {"20", 4}, {"11", 5}, {"15", 9}]},
        {"grid_4.png", []},
        {"grid_5.png", [{"13", 1}, {"19", 2}, {"17", 3}, {"20", 4}, {"16", 5}, {"11", 6}, {"24", 7}, {"15", 8}, {"28", 9}]},
        {"grid_6.png", [{"20", 2}, {"17", 6}, {"23", 9}, {"15", 13}, {"10", 19}, {"19", 22}]},
        {"grid_7.png", [{"19", 2}, {"21", 4}, {"10", 5}, {"23", 11}, {"15", 13}]}
      ]
  """
  def driver(path \\ "images/") do
    # Getting the path of images
    image_path = path <> "*.png"
    # Creating a list of all images paths with extension .png
    image_list = Path.wildcard(image_path)

    # Parsing through all the images to get final output using the two funtions which teams need to complete
    Enum.map(image_list, fn x ->
      {String.trim_leading(x, path), identifyCellNumbers(x) |> identifyCellNumbersWithLocations}
    end)
  end
end
