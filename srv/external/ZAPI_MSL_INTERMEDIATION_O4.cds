/* checksum : 6a047d53a7a08262ed202fc506f6a3da */
@cds.external : true
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@SAP__support.TechnicalInfoLinks.Url : '../../../../default/iwbep/common/0001/$metadata'
@SAP__support.TechnicalInfoLinks.FunctionImport : 'GetTechnicalInfoLinks'
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features.DocumentDescriptionReference : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat : true
@PDF.Features.Border : true
@PDF.Features.CoverPage : true
@PDF.Features.FitToPage : true
@PDF.Features.FontName : true
@PDF.Features.FontSize : true
@PDF.Features.HeaderFooter : true
@PDF.Features.IANATimezoneFormat : true
@PDF.Features.Margin : true
@PDF.Features.Padding : true
@PDF.Features.ResultSizeDefault : 20000
@PDF.Features.ResultSizeMaximum : 20000
@PDF.Features.Signature : true
@PDF.Features.TextDirectionLayout : true
@PDF.Features.Treeview : true
@PDF.Features.UploadToFileShare : true
@Capabilities.BatchSupport.SupportedFormats : [ 'application/json', 'multipart/mixed' ]
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service ZAPI_MSL_INTERMEDIATION_O4 {
  @cds.external : true
  type SAP__Message {
    code : String not null;
    message : String not null;
    target : String;
    additionalTargets : many String not null;
    transition : Boolean not null;
    @odata.Type : 'Edm.Byte'
    numericSeverity : Integer not null;
    longtextUrl : String;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Principal product consumption'
  @Common.Messages : SAP__Messages
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'PrincipalUUID', 'ExternalCode', 'Name' ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [ 'PrincipalUUID' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  entity PrincipalProducts {
    @Core.Computed : true
    @Common.Label : 'UUID'
    @Common.QuickInfo : '16 Byte UUID in 16 Bytes (Raw Format)'
    key ProductUUID : UUID not null;
    @Common.Label : 'Principal'
    @Core.Immutable : true
    @Common.Heading : 'UUID'
    @Common.QuickInfo : '16 Byte UUID in 16 Bytes (Raw Format)'
    PrincipalUUID : UUID;
    @Common.Label : 'Product Code'
    @Common.Heading : 'Product Code'
    @Common.QuickInfo : 'Principal Product Code'
    ExternalCode : String(40) not null;
    @Common.Label : 'Name'
    Name : String(100) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Creado por'
    @Common.QuickInfo : 'Creado por usuario'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_CREATION_USER'
    CreatedBy : String(12) not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Creado el'
    @Common.Heading : 'Creada el'
    @Common.QuickInfo : 'Fecha/Hora de creación'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_CREATION_TSTMPL'
    CreatedAt : Timestamp;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Modificados por'
    @Common.Heading : 'Autor mod.'
    @Common.QuickInfo : 'Última modificación de instancia local por usuario'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LOCINST_LASTCHANGE_USER'
    LocalLastChangedBy : String(12) not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Modificados el'
    @Common.Heading : 'Modif.el'
    @Common.QuickInfo : 'Fecha y hora de última modificación de la instancia local'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LOCINST_LASTCHANGE_TSTMPL'
    LocalLastChangedAt : Timestamp;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Modificados el'
    @Common.Heading : 'Modif.el'
    @Common.QuickInfo : 'Fecha y hora de la última modificación'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LASTCHANGE_TSTMPL'
    LastChangedAt : Timestamp;
    SAP__Messages : many SAP__Message not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Intermediation partner consumption'
  @Common.Messages : SAP__Messages
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  entity Principals {
    @Core.Computed : true
    @Common.Label : 'UUID'
    @Common.QuickInfo : '16 Byte UUID in 16 Bytes (Raw Format)'
    key PrincipalUUID : UUID not null;
    @Common.Label : 'Partner Code'
    @Common.Heading : 'External Code for Intermediation Partner'
    @Common.QuickInfo : 'External code for intermediation partner'
    ExternalCode : String(20) not null;
    @Common.Label : 'Name'
    Name : String(100) not null;
    @Common.Label : 'Commission %'
    @Common.Heading : 'Default Commission Percentage'
    @Common.QuickInfo : 'Commission percentage'
    DefaultCommissionPct : Decimal(5, 2) not null;
    @Common.Label : 'Status'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Heading : 'Principal Lifecycle Status'
    @Common.QuickInfo : 'Principal lifecycle status'
    Status : String(12) not null;
    @Common.Label : 'SAP Business Partner'
    SapBusinessPartner : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Creado por'
    @Common.QuickInfo : 'Creado por usuario'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_CREATION_USER'
    CreatedBy : String(12) not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Creado el'
    @Common.Heading : 'Creada el'
    @Common.QuickInfo : 'Fecha/Hora de creación'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_CREATION_TSTMPL'
    CreatedAt : Timestamp;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Modificados por'
    @Common.Heading : 'Autor mod.'
    @Common.QuickInfo : 'Última modificación de instancia local por usuario'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LOCINST_LASTCHANGE_USER'
    LocalLastChangedBy : String(12) not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Modificados el'
    @Common.Heading : 'Modif.el'
    @Common.QuickInfo : 'Fecha y hora de última modificación de la instancia local'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LOCINST_LASTCHANGE_TSTMPL'
    LocalLastChangedAt : Timestamp;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Modificados el'
    @Common.Heading : 'Modif.el'
    @Common.QuickInfo : 'Fecha y hora de la última modificación'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABP_LASTCHANGE_TSTMPL'
    LastChangedAt : Timestamp;
    SAP__Messages : many SAP__Message not null;
  } actions {
    action Suspend() returns Principals not null;
    action Reactivate() returns Principals not null;
    action SubmitForReview() returns Principals not null;
    action Reject() returns Principals not null;
    action Deactivate() returns Principals not null;
    action Approve() returns Principals not null;
  };
};
