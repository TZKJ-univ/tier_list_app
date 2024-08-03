class SetDefaultPositionOnTierlistitems < ActiveRecord::Migration[7.0]
  def up
    # nilのpositionにデフォルト値を設定
    Tierlistitem.where(position: nil).find_each do |item|
      # rank内での最大positionを取得し、そこに+1することでユニークなpositionを設定
      max_position = Tierlistitem.where(tierlist_id: item.tierlist_id, rank: item.rank).maximum(:position) || 0
      item.update!(position: max_position + 1)
    end
  end

  def down
    # 変更を元に戻す場合の処理（今回は特に何もしない）
  end
end