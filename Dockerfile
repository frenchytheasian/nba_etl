FROM public.ecr.aws/lambda/python:3.12

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install -r requirements.txt

COPY lambdas/ ${LAMBDA_TASK_ROOT}

CMD [ "lambdas.update_gamelogs.lambda_handler"]
