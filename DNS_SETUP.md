# Configuración de DNS para GitHub Pages

Este documento explica cómo configurar el DNS para que el sitio de GitHub Pages esté disponible en **www.tecnomod-um.org**.

## Cambios realizados en el repositorio

1. **Archivo CNAME**: Se ha creado un archivo `CNAME` en la raíz del repositorio con el dominio `www.tecnomod-um.org`.

2. **sushi-config.yaml**: Se ha eliminado el `baseurl: /RES-Q-FHIR-IG` para que el sitio funcione desde la raíz del dominio personalizado.

3. **GitHub Actions**: Se ha modificado el workflow `.github/workflows/ci.yml` para copiar el archivo CNAME al directorio `output` antes del despliegue.

## Configuración DNS requerida

Para completar la configuración, es necesario configurar los registros DNS en el proveedor de dominio **tecnomod-um.org**:

### Opción 1: Registro CNAME (Recomendado para subdominios)

Añade un registro CNAME en tu proveedor DNS:

```
Tipo:    CNAME
Nombre:  www
Valor:   tecnomod-um.github.io.
TTL:     3600 (o el valor por defecto)
```

### Opción 2: Registros A (Para dominio apex)

Si también quieres que `tecnomod-um.org` (sin www) funcione, añade estos registros A:

```
Tipo:    A
Nombre:  @
Valor:   185.199.108.153
TTL:     3600

Tipo:    A
Nombre:  @
Valor:   185.199.109.153
TTL:     3600

Tipo:    A
Nombre:  @
Valor:   185.199.110.153
TTL:     3600

Tipo:    A
Nombre:  @
Valor:   185.199.111.153
TTL:     3600
```

Y también el registro CNAME para www:

```
Tipo:    CNAME
Nombre:  www
Valor:   tecnomod-um.github.io.
TTL:     3600
```

## Configuración en GitHub

Después de configurar el DNS:

1. Ve a la configuración del repositorio en GitHub: `Settings` > `Pages`
2. Verifica que el dominio personalizado aparezca como `www.tecnomod-um.org`
3. Marca la opción `Enforce HTTPS` una vez que el certificado SSL esté disponible (puede tardar unos minutos)

## Verificación

Una vez configurado el DNS (puede tardar de 24 a 48 horas en propagarse completamente), puedes verificar la configuración con:

```bash
# Verificar el registro CNAME
dig www.tecnomod-um.org CNAME

# Verificar los registros A (si se configuraron)
dig tecnomod-um.org A

# Verificar que el sitio esté accesible
curl -I https://www.tecnomod-um.org
```

## Notas importantes

- La propagación DNS puede tardar entre minutos y 48 horas, dependiendo del TTL configurado
- GitHub Pages generará automáticamente un certificado SSL/TLS gratuito mediante Let's Encrypt
- El sitio seguirá siendo accesible en la URL original de GitHub Pages (`tecnomod-um.github.io/RES-Q-FHIR-IG`) hasta que se complete la migración
- Una vez que el DNS esté configurado y el HTTPS habilitado, el sitio redirigirá automáticamente HTTP a HTTPS

## Referencias

- [Documentación oficial de GitHub Pages sobre dominios personalizados](https://docs.github.com/es/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [Solución de problemas de dominios personalizados](https://docs.github.com/es/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-custom-domains-and-github-pages)
