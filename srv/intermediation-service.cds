using { ZAPI_MSL_INTERMEDIATION_O4 as RAP }
    from './external/ZAPI_MSL_INTERMEDIATION_O4';

@path: '/api/intermediation'
service IntermediationService {
    @readonly
    entity Principals as projection on RAP.Principals;

    @readonly
    entity PrincipalProducts as projection on RAP.PrincipalProducts;
}
