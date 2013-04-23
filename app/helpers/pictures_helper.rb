module PicturesHelper
  def previous_picture(pic)
    if pic.trip_id.present?
      arrayed = pic.trip.pictures.order(:created_at).map {|a| a.id}
    else
      arrayed = Picture.all.sort_by(:created_at).map {|a| a.id}
    end
    if arrayed.find_index(pic.id) == 0
      nil
    else
      Picture.find(arrayed[arrayed.find_index(pic.id) - 1])
    end
  end

  def next_picture(pic)
    if pic.trip_id.present?
      arrayed = pic.trip.pictures.order(:created_at).map {|a| a.id}
    else
      arrayed = Picture.all.sort_by(:created_at).map {|a| a.id}
    end
    if arrayed.find_index(pic.id) == arrayed.count - 1
      nil
    else
      Picture.find(arrayed[arrayed.find_index(pic.id) + 1])
    end
  end
end
