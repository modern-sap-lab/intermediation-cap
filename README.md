# intermediation-cap

[Versión en español](README_es.md)

SAP Cloud Application Programming Model (CAP) service facade for the `modern-sap-lab` commercial intermediation scenario.

This repository represents the **external-facing API layer** of the lab. Its purpose is to expose consumer-oriented services without duplicating the intermediation business domain implemented in **ABAP Cloud / RAP**.

## Architectural role

`intermediation-cap` sits at the boundary between external consumers and the SAP intermediation domain.

```text
External consumers / channels
            |
            v
           CAP
            |
            v
     RAP service contract
            |
            v
 ABAP Cloud / intermediation domain
            |
            v
 S/4HANA and SAP services
```

The exact integration path may vary by use case. SAP Integration Suite can be introduced where connectivity, routing, transformation or protocol adaptation is required.

The key rule is:

> CAP adapts and exposes the domain; it does not reimplement it.

## Clean Core approach

The wider `modern-sap-lab` project follows a Clean Core architecture:

| Component | Responsibility |
|---|---|
| **S/4HANA** | Standard ERP capabilities such as Business Partner, billing, taxes, payment terms and accounting |
| **ABAP Cloud / RAP** | Core intermediation domain, transactional business objects and business rules |
| **CAP** | External-facing APIs, consumer-specific service composition and protocol-facing adaptation |
| **SAP Integration Suite** | Connectivity, routing, transformation and protocol adaptation |
| **SAP BTP** | Side-by-side runtime and decoupled extension capabilities |

This separation avoids moving standard ERP responsibilities outside S/4HANA and avoids duplicating business rules across ABAP and CAP.

## Business scenario

The company acts as a commercial intermediary.

A **Principal** is a company whose products are intermediated — for example, a manufacturer, wholesaler, distributor or another company that sells products directly to its customers.

The intermediary does not purchase or stock the goods:

1. a customer orders products;
2. the Principal sells and ships directly to the customer;
3. the applicable commercial conditions are determined;
4. delivered quantities are confirmed and reconciled;
5. commission is calculated on confirmed delivered business;
6. the intermediary invoices its service to the Principal.

From the intermediary's SAP perspective, the Principal is expected to map primarily to a **Business Partner with Customer role**, because the Principal purchases the intermediation service.

## Responsibility boundary

The CAP layer may:

- expose APIs designed for external or non-RAP consumers;
- reshape RAP data into consumer-oriented contracts;
- compose data from more than one backend service when justified;
- provide API-level validation related to the external contract;
- isolate external consumers from internal RAP service evolution;
- participate in authentication, authorization and API exposure on SAP BTP.

The CAP layer must not:

- duplicate tariff, offer, order, delivery or commission business rules already owned by the ABAP domain;
- become an alternative persistence model for the same transactional business objects;
- bypass RAP contracts by depending on ABAP persistence tables;
- absorb Integration Suite responsibilities such as generic routing or protocol mediation without a business reason;
- recreate standard S/4HANA capabilities.

## Domain evolution

The intermediation domain is designed to evolve incrementally through concepts such as:

- Principal management;
- Principal products;
- dated tariffs;
- temporary offers;
- pricing and economic snapshots;
- orders;
- confirmed deliveries;
- commission calculation;
- settlements;
- S/4HANA integration.

Not every capability belongs in this repository. CAP exposes or adapts capabilities whose source of truth remains in the appropriate backend component.

## Technology

Current development baseline:

- **SAP Cloud Application Programming Model (CAP)**
- **Node.js 24.21.0**
- **npm 11.19.0**
- **@sap/cds 10.1.2**
- **SAP Business Application Studio**
- **SAP BTP / Cloud Foundry** as the intended deployment environment

Version numbers describe the current lab baseline and may evolve as the project progresses.

## Development

After cloning the repository:

```bash
npm install
npx cds watch
```

CAP will start the local development server and expose the services defined by the project.

Additional environment configuration will be documented as external RAP services, authentication and BTP bindings are introduced.

## Status

**Initial CAP bootstrap / first service contract pending.**

The remote repository currently establishes the role of the CAP component. Functional external service contracts and RAP integration will be added incrementally.

The first implementation goal is to create a minimal end-to-end path in which CAP consumes a released RAP service and exposes a deliberately consumer-oriented API without reproducing the underlying business logic.

## Design principles

- **Clean Core first** — no unnecessary custom logic in S/4HANA.
- **One source of truth** — the business domain is not duplicated in CAP.
- **Explicit contracts** — CAP consumes released service contracts rather than backend persistence.
- **Consumer-oriented APIs** — external contracts are designed for their consumers, not as blind copies of internal entities.
- **Separation of concerns** — domain logic, API adaptation and integration responsibilities remain distinct.
- **Incremental delivery** — each step should produce a small, understandable and demonstrable result.
- **No technology for technology's sake** — CAP is used where it provides a clear architectural responsibility.

## Related repository

- [`modern-sap-lab/intermediation-abap`](https://github.com/modern-sap-lab/intermediation-abap) — ABAP Cloud / RAP implementation of the core intermediation domain.

## Purpose

`modern-sap-lab` is a personal technical lab and portfolio project focused on modern SAP development and architecture.

It is intended to demonstrate architectural reasoning and hands-on use of ABAP Cloud, RAP, CAP, SAP BTP, Integration Suite and S/4HANA under Clean Core principles. It does not represent a production customer implementation.
