using { ZAPI_MSL_INTERMEDIATION_O4 as RAP }
    from './external/ZAPI_MSL_INTERMEDIATION_O4';

@path: '/api/intermediation'
service IntermediationService {
    @readonly
    entity Principals as projection on RAP.Principals
        actions {
            action Suspend() returns Principals;
            action Reactivate() returns Principals;
            action SubmitForReview() returns Principals;
            action Reject() returns Principals;
            action Deactivate() returns Principals;
            action Approve() returns Principals;
        };

    entity PrincipalProducts as projection on RAP.PrincipalProducts;
}
