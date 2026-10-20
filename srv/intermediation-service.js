import cds from '@sap/cds';

export default cds.service.impl(async function () {
  const rap = await cds.connect.to('ZAPI_MSL_INTERMEDIATION_O4');

  this.on('READ', 'Principals', req => {
    return rap.run(req.query);
  });

  this.on('READ', 'PrincipalProducts', req => {
    return rap.run(req.query);
  });
});
