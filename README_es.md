# intermediation-cap

[English version](README.md)

Fachada de servicios basada en SAP Cloud Application Programming Model (CAP) para el escenario de intermediación comercial de `modern-sap-lab`.

Este repositorio representa la **capa de API orientada a consumidores externos** del laboratorio. Su finalidad es exponer servicios adaptados a esos consumidores sin duplicar el dominio de intermediación implementado en **ABAP Cloud / RAP**.

## Papel arquitectónico

`intermediation-cap` se sitúa en la frontera entre los consumidores externos y el dominio SAP de intermediación.

```text
Consumidores / canales externos
              |
              v
             CAP
              |
              v
      Contrato de servicio RAP
              |
              v
 ABAP Cloud / dominio de intermediación
              |
              v
   S/4HANA y servicios SAP
```

El recorrido exacto de una integración puede variar según el caso de uso. SAP Integration Suite puede incorporarse cuando sean necesarias conectividad, enrutamiento, transformación o adaptación de protocolos.

La regla principal es:

> CAP adapta y expone el dominio; no lo vuelve a implementar.

## Enfoque Clean Core

El proyecto global `modern-sap-lab` sigue una arquitectura Clean Core:

| Componente | Responsabilidad |
|---|---|
| **S/4HANA** | Capacidades ERP estándar como Business Partner, facturación, impuestos, condiciones de pago y contabilidad |
| **ABAP Cloud / RAP** | Dominio central de intermediación, objetos de negocio transaccionales y reglas de negocio |
| **CAP** | APIs externas, composición de servicios orientada al consumidor y adaptación en la frontera |
| **SAP Integration Suite** | Conectividad, enrutamiento, transformación y adaptación de protocolos |
| **SAP BTP** | Entorno side-by-side y capacidades de extensión desacopladas |

Esta separación evita trasladar fuera de S/4HANA responsabilidades estándar del ERP y evita duplicar reglas de negocio entre ABAP y CAP.

## Escenario de negocio

La empresa actúa como intermediaria comercial.

Un **Principal** es la empresa cuyos productos se intermedian —por ejemplo, una fábrica, un mayorista, un distribuidor u otra empresa que vende productos directamente a sus clientes—.

La empresa intermediaria no compra ni almacena la mercancía:

1. un cliente realiza un pedido;
2. el Principal vende y envía directamente al cliente;
3. se determinan las condiciones comerciales aplicables;
4. se confirman y concilian las cantidades realmente servidas;
5. la comisión se calcula sobre el negocio servido y confirmado;
6. posteriormente, la empresa intermediaria factura su servicio al Principal.

Desde la perspectiva SAP de la empresa intermediaria, se prevé que el Principal se corresponda principalmente con un **Business Partner con rol de cliente**, porque es quien adquiere el servicio de intermediación.

## Límite de responsabilidades

La capa CAP puede:

- exponer APIs diseñadas para consumidores externos o no orientados a RAP;
- adaptar datos RAP a contratos pensados para cada consumidor;
- componer datos de varios servicios backend cuando exista una justificación;
- aplicar validaciones propias del contrato externo;
- aislar a los consumidores externos de la evolución interna de los servicios RAP;
- participar en autenticación, autorización y exposición de APIs sobre SAP BTP.

La capa CAP no debe:

- duplicar reglas de tarifas, ofertas, pedidos, entregas o comisiones cuyo propietario sea el dominio ABAP;
- convertirse en un modelo de persistencia alternativo para los mismos objetos de negocio transaccionales;
- saltarse los contratos RAP accediendo directamente a tablas de persistencia ABAP;
- absorber responsabilidades propias de Integration Suite, como enrutamiento genérico o mediación de protocolos, sin una razón funcional;
- recrear capacidades estándar de S/4HANA.

## Evolución del dominio

El dominio de intermediación está diseñado para evolucionar de forma incremental mediante conceptos como:

- gestión de Principals;
- productos del Principal;
- tarifas con vigencia temporal;
- ofertas temporales;
- snapshots económicos y de precios;
- pedidos;
- entregas confirmadas;
- cálculo de comisiones;
- liquidaciones;
- integración con S/4HANA.

No todas estas capacidades pertenecen a este repositorio. CAP expone o adapta aquellas cuyo origen de verdad permanece en el componente backend correspondiente.

## Tecnología

Línea base actual de desarrollo:

- **SAP Cloud Application Programming Model (CAP)**
- **Node.js 24.21.0**
- **npm 11.19.0**
- **@sap/cds 10.1.2**
- **SAP Business Application Studio**
- **SAP BTP / Cloud Foundry** como entorno previsto de despliegue

Las versiones reflejan la línea base actual del laboratorio y podrán evolucionar con el proyecto.

## Desarrollo

Después de clonar el repositorio:

```bash
npm install
npx cds watch
```

CAP iniciará el servidor local de desarrollo y expondrá los servicios definidos en el proyecto.

La configuración adicional se documentará conforme se incorporen servicios RAP externos, autenticación y bindings de SAP BTP.

## Estado

**Bootstrap inicial de CAP / definición arquitectónica.**

El repositorio remoto establece actualmente el papel del componente CAP. Los contratos funcionales externos y la integración con RAP se incorporarán de forma incremental.

El primer objetivo de implementación es construir un recorrido mínimo de extremo a extremo en el que CAP consuma un servicio RAP liberado y exponga una API deliberadamente orientada al consumidor, sin reproducir la lógica de negocio subyacente.

## Principios de diseño

- **Clean Core ante todo** — sin lógica personalizada innecesaria dentro de S/4HANA.
- **Una única fuente de verdad** — el dominio de negocio no se duplica en CAP.
- **Contratos explícitos** — CAP consume contratos de servicio liberados, no la persistencia del backend.
- **APIs orientadas al consumidor** — los contratos externos se diseñan para sus consumidores y no como copias mecánicas de entidades internas.
- **Separación de responsabilidades** — dominio, adaptación de APIs e integración se mantienen diferenciados.
- **Entrega incremental** — cada paso debe producir un resultado pequeño, comprensible y demostrable.
- **Nada de tecnología por la tecnología** — CAP se utiliza porque cumple una responsabilidad arquitectónica concreta.

## Repositorio relacionado

- [`modern-sap-lab/intermediation-abap`](https://github.com/modern-sap-lab/intermediation-abap) — implementación en ABAP Cloud / RAP del dominio central de intermediación.

## Propósito

`modern-sap-lab` es un laboratorio técnico personal y un proyecto de portfolio centrado en desarrollo y arquitectura SAP moderna.

Su objetivo es demostrar criterio arquitectónico y uso práctico de ABAP Cloud, RAP, CAP, SAP BTP, Integration Suite y S/4HANA bajo principios Clean Core. No representa una implantación productiva de un cliente.
