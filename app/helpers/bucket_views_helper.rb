module BucketViewsHelper
  def default_bucket_view?
    bubble_filter_params.values.all?(&:blank?) || bubble_filter_params.to_h == Bucket::View.default_filters
  end

  def bubble_filter_form_tag(path, method:, id:)
    form_tag path, method: method, id: id do
      yield if block_given?

      if params[:order_by].present?
        concat hidden_field_tag(:order_by, params[:order_by])
      end

      if params[:status].present?
        concat hidden_field_tag(:status, params[:status])
      end

      Array(params[:assignee_ids]).each do |assignee_id|
        concat hidden_field_tag("assignee_ids[]", assignee_id, id: nil)
      end

      Array(params[:tag_ids]).each do |tag_id|
        concat hidden_field_tag("tag_ids[]", tag_id, id: nil)
      end
    end
  end
end
