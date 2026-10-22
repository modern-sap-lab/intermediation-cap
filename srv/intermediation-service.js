import cds from '@sap/cds';

export default cds.service.impl(async function () {
  const rap = await cds.connect.to('ZAPI_MSL_INTERMEDIATION_O4');

  this.on('READ', 'Principals', req => {
    return rap.run(req.query);
  });

  this.on('READ', 'PrincipalProducts', req => {
    return rap.run(req.query);
  });

  this.on('CREATE', 'PrincipalProducts', req => {
    return rap.run(req.query);
  });

  this.on('UPDATE', 'PrincipalProducts', req => {
    return rap.run(req.query);
  });

  this.on('DELETE', 'PrincipalProducts', req => {
    return rap.run(req.query);
  });

  const principalActions = [
    'Suspend',
    'Reactivate',
    'SubmitForReview',
    'Reject',
    'Deactivate',
    'Approve'
  ];

  for (const action of principalActions) {
    this.on(action, 'Principals', req => {
      return rap.send({
        event: action,
        entity: 'Principals',
        params: [...req.params],
        data: req.data
      });
    });
  }
});
