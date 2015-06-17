module DataTypes
  def self.all
    [ 
      {
        code: 'id',
        title: 'ID',
        data_type: 'Integer'
      },
      {
        code: 'email',
        title: 'Email Address',
        data_type: 'String'
      },
      {
        code: 'url',
        title: 'URL',
        data_type: 'String'
      },
      {
        code: 'phone',
        title: 'Phone Number',
        data_type: 'String'
      },
      {
        code: 'integer',
        title: 'Integer Number',
        data_type: 'Integer'
      },
      {
        code: 'decimal',
        title: 'Decimal Number',
        data_type: 'Decimal'
      },
      {
        code: 'currency',
        title: 'Currency',
        data_type: 'decimal'
      },
      {
        code: 'percentage',
        title: 'Percentage',
        data_type: 'Decimal'
      },
      {
        code: 'date',
        title: 'Date',
        data_type: 'Date'
      },
      {
        code: 'time',
        title: 'Time',
        data_type: 'Time'
      },
      {
        code: 'datetime',
        title: 'Date and Time',
        data_type: 'DateTime'
      },
      {
        code: 'duration',
        title: 'Duration',
        data_type: 'Time'
      },
      {
        code: 'city',
        title: 'City',
        data_type: 'String'
      },
      {
        code: 'adress',
        title: 'Street Address',
        data_type: 'String'
      },
      {
        code: 'state',
        title: 'State / Province',
        data_type: 'String'
      },
      {
        code: 'zipcode',
        title: 'Zip Code / Postal Code',
        data_type: 'String'
      },
      {
        code: 'country',
        title: 'Country',
        data_type: 'String'
      },
      {
        code: 'boolean',
        title: 'True/False',
        data_type: 'Boolean'
      },
      {
        code: 'longtext',
        title: 'Long Text',
        data_type: 'Text'
      },
      {
        code: 'generictext',
        title: 'Text',
        data_type: 'String'
      }
    ]
  end
end
